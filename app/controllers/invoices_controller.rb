class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def show
    @invoice = Invoice.new
    authorize Invoice
    @account = Account.new
    @account.id = params[:id].to_i
    @lines = DoubleEntry::Line.where(scope: params[:id])
    @user = User.find(@account.id)
    @subscriptions = @user.subscriptions
  end

  def update
    @user_id = invoice_params[:id]
    authorize Invoice
    start =  params[:invoice]
    params[:invoice][:start] = Date.civil(start["start(1i)"].to_i, start["start(2i)"].to_i, start["start(3i)"].to_i)
    stop =  params[:invoice]
    params[:invoice][:stop] = Date.civil(stop["start(1i)"].to_i, stop["start(2i)"].to_i, stop["start(3i)"].to_i)
    amount = Money.from_amount(invoice_params[:invoice][:amount].to_d,"USD")
    cn_params = {user_id: @user_id,
      amount: amount,
      note: invoice_params[:invoice][:note],
      start: invoice_params[:invoice][:start],
      stop: invoice_params[:invoice][:stop]
    }

    respond_to do |format|
      if CreateInvoiceService.new.call(cn_params)
        format.html { redirect_to invoice_path(id: @user_id), notice: 'Invoice was successfully created.' }
      else
        format.html { redirect_to invoice_path(id: @user_id), notice: 'Invoice failed.' }
      end
  end
  end


  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.permit(:id, invoice: [:note, :amount, :start, :stop])
  end
end
