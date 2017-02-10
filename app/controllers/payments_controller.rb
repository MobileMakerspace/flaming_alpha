class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @payment = Payment.new
    authorize Payment
    @account = Account.new
    @account.id = params[:id].to_i
    @lines = DoubleEntry::Line.where(scope: params[:id])
    @user = User.find(@account.id)
    @subscriptions = @user.subscriptions
  end

  def update
    @user_id = payment_params[:id]
    authorize Payment
    amount = Money.from_amount(payment_params[:payment][:amount].to_d,'USD')
    cn_params = {user_id: @user_id,
      amount: amount,
      note: payment_params[:payment][:note]
    }

    respond_to do |format|
      if AcceptPaymentService.new.call(cn_params)
        format.html { redirect_to payment_path(id: @user_id), notice: 'Payment was successfully created.' }
      else
        format.html { redirect_to payment_path(id: @user_id), notice: 'Payment failed.' }
      end
  end
  end


  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.permit(:id, payment: [:note, :amount])
  end
end
