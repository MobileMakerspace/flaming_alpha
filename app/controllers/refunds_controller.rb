class RefundsController < ApplicationController
  before_action :authenticate_user!

  def show
    @refund = Refund.new
    authorize Refund
    @account = Account.new
    @account.id = params[:id].to_i
    @lines = DoubleEntry::Line.where(scope: params[:id])
    @user = User.find(@account.id)
    @subscriptions = @user.subscriptions
  end

  def update
    @user_id = refund_params[:id]
    authorize Refund
    amount = Money.from_amount(refund_params[:refund][:amount].to_d,"USD")
    cn_params = {user_id: @user_id,
      amount: amount,
      note: refund_params[:refund][:note]
    }

    respond_to do |format|
      if CreateRefundService.new.call(cn_params)
        format.html { redirect_to refund_path(id: @user_id), notice: 'Refund was successfully created.' }
      else
        format.html { redirect_to refund_path(id: @user_id), notice: 'Refund failed.' }
      end
  end
  end


  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def refund_params
    #params.require(:credit_note,:id).permit(:id, :note, :amount_cents)
    params.permit(:id, refund: [:note, :amount])
  end
end
