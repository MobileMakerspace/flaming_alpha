class AcceptPaymentService
  def call(params)
    #:user_id, :amount
    user = User.find(params[:user_id])
    receivables = DoubleEntry.account(:accounts_receivable, :scope => user)
    cash = DoubleEntry.account(:cash)
    amount = params[:amount]
    note = params[:note] || ""
    DoubleEntry.transfer(
      Money.new(amount),
      :from => cash,
      :to   => receivables,
      :code => :payment,
      :metadata => {:note => note}
    )
    true
  end
end
