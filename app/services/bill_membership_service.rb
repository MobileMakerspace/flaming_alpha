class BillMembershipService
  def call(params)
    # :user_id, :sender_id, :quantity, :plan_id
    user = User.find(params[:user_id])
    receivables = DoubleEntry.account(:accounts_receivable, :scope => user)
    sales = DoubleEntry.account(:sales_revenue)
    price = Plan.find(params[:plan_id]).price
    price = price * params[:quantity]
    DoubleEntry.transfer(
      Money.new(price),
      :from => receivables,
      :to   => sales,
      :code => :membership
    )
  end
end
