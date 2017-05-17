class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @subscriptions = Subscription.all
    @active = @subscriptions.active
    authorize Subscription
  end

  def new
    @subscription = Subscription.new
    authorize Subscription
    @plans = Plan.all
    # Don't allow if there is an existing subscription
    res = Subscription.where("user_id = ? AND stop IS ?", current_user.id, nil).empty?
    if !res
      redirect_to account_path(current_user.id), notice: 'Stop existing subscription before starting a new subscription.'
    end
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user unless current_user.admin?

    authorize @subscription
    respond_to do |format|
      if @subscription.save
        sub_params = {subscription_id: @subscription.id}
        BillMembershipService.new.first_bill(sub_params)
        format.html { redirect_to root_path(), notice: 'Subscription was successfully created.' }
      else
        @plans = Plan.all
        puts @subscription.errors
        format.html { render :new, notice: @subscription.errors.full_messages}
      end
    end
  end
  def edit
    @subscription = Subscription.find(params[:id])
    authorize @subscription
  end

  def update
    @subscription = Subscription.find(params[:id])
    authorize @subscription
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to account_path(@subscription.user.id), notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_id, :start, :stop)
  end
end
