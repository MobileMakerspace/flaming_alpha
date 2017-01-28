class CreateInvoiceService
  def call(params)
    user = User.find(params[:user_id])
    receivables = DoubleEntry.account(:accounts_receivable, :scope => user)
    sales = DoubleEntry.account(:sales_revenue)
    amount = params[:amount]
    DoubleEntry.transfer(
      Money.new(amount),
      :from => receivables,
      :to   => sales,
      :code => :manual_invoice,
      :metadata => {:note=> params[:note], :start => params[:start], :stop => params[:stop]}
    )
    true
  end
end
