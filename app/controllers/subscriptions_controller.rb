class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  # TODO after_action :verify_authorized

  def new
    @subscription = Subscription.new
    @plans = Plan.all
    @users = User.all
  end

  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to root_path(), notice: 'Subscription was successfully created.' }
      else
        format.html { render :new, notice: @subscription.errors}
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_id, :start)
  end
end
