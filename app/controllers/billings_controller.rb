class BillingsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def new
    @bill = Billing.new
    authorize @bill
  end

  def create
    @bill = Billing.new
    authorize @bill
    start = Date.parse(billing_params[:start])
    respond_to do |format|
        bill_params = {start: start}
        BillMembershipService.new.bill_active_members(bill_params)
        format.html { redirect_to subscriptions_path(), notice: 'Billing was successfully processed.' }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def billing_params
    params.require(:billing).permit(:start)
  end
end
