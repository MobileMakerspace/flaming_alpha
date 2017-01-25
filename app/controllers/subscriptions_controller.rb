class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @subscriptions = Subscription.all
    authorize Subscription
  end

  def new
    @subscription = Subscription.new
    authorize Subscription
  end

  def create
    @subscription = Subscription.new(subscription_params)
    authorize @subscription
    respond_to do |format|
      if @subscription.save
        sub_params = {subscription_id: @subscription.id}
        BillMembershipService.new.first_bill(sub_params)
        format.html { redirect_to root_path(), notice: 'Subscription was successfully created.' }
      else
        puts @subscription.errors
        format.html { render :new, notice: @subscription.errors.full_messages}
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_id, :start, :stop)
  end
end
