class CreditNotesController < ApplicationController
  before_action :authenticate_user!

  def show
    @credit_note = CreditNote.new
    authorize CreditNote
    @account = Account.new
    @account.id = params[:id].to_i
    @lines = DoubleEntry::Line.where(scope: params[:id])
    @user = User.find(@account.id)
    @subscriptions = @user.subscriptions
  end

  def update
    @user_id = credit_note_params[:id]
    authorize CreditNote
    amount = Money.from_amount(credit_note_params[:credit_note][:amount].to_d,"USD")
    cn_params = {user_id: @user_id,
      amount: amount,
      note: credit_note_params[:credit_note][:note]
    }

    respond_to do |format|
      if CreateCreditNoteService.new.call(cn_params)
        format.html { redirect_to credit_note_path(id: @user_id), notice: 'Credit note was successfully created.' }
      else
        format.html { redirect_to credit_note_path(id: @user_id), notice: 'Credit note failed.' }
      end
  end
  end


  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def credit_note_params
    #params.require(:credit_note,:id).permit(:id, :note, :amount_cents)
    params.permit(:id, credit_note: [:note, :amount])
  end
end
