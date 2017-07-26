class CreateRefundService
  def call(params)
    user = User.find(params[:user_id])
    receivables = DoubleEntry.account(:accounts_receivable, :scope => user)
    refunds_accounts_receivable = DoubleEntry.account(:refunds_accounts_receivable)
    amount = params[:amount]

    DoubleEntry.transfer(
      Money.new(amount),
      :from => receivables,
      :to   => refunds_accounts_receivable,
      :code => :customer_refund,
      :metadata => {:note => params[:note]}
    )
    true
  end
end
