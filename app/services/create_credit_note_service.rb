class CreateCreditNoteService
  def call(params)
    user = User.find(params[:user_id])
    receivables = DoubleEntry.account(:accounts_receivable, :scope => user)
    sales = DoubleEntry.account(:sales_revenue)
    amount = params[:amount]

    DoubleEntry.transfer(
      Money.new(amount),
      :from => sales,
      :to   => receivables,
      :code => :credit_note,
      :metadata => {:note => params[:note]}
    )
    true
  end
end
