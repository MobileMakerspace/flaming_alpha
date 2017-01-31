class BillMembershipService
  def batch_billing(params)
    #
    # # billing is the first day of the month
    # billing_date = Date.today.at_beginning_of_month
    # previous_billing_date = Date.today.last_month.at_beginning_of_month
    # subs = Subscription.all
    # subs.each { |s|
    #   if !s.last_billed
    #     puts "#{s.user.name} has not been billed for #{s.plan.name}"
    #     bill_params = {user_id: s.user.id, plan_id: s.plan.id}
    #   else
    #     puts "#{s.user.name} was last billed on #{s.lastbilled} for #{s.plan.name}"
    #     if previous_billing_date
    #     # Is the subscription active?
    #     if s.stop < billing_date
    #       puts "#{s.user.name}'s subscription has ended."
    #       if s.stop.beginning_of_month == s.last_billed
    #         puts "#{s.user.name}'s subscription should not be billed."
    #       end
    #     end
    #   end
    # }
  end

  def first_bill(params)
    subscription = Subscription.find(params[:subscription_id])
    days_in_month = (subscription.start.at_end_of_month - subscription.start.at_beginning_of_month) + 1
    days_to_bill = (days_in_month - subscription.start.day) + 1
    prorate_quantity = days_to_bill / days_in_month
    bill_params = {
      user_id: subscription.user_id,
      plan_id: subscription.plan_id,
      quantity: prorate_quantity,
      start: subscription.start,
      stop: subscription.start.at_end_of_month
      }
    self.call(bill_params)
    subscription.last_billed = Date.today
    subscription.save
  end

  def call(params)
    # :user_id, :sender_id, :quantity, :plan_id
    user = User.find(params[:user_id])
    receivables = DoubleEntry.account(:accounts_receivable, :scope => user)
    sales = DoubleEntry.account(:sales_revenue)
    price = Plan.find(params[:plan_id]).price
    amount = price * params[:quantity]
    DoubleEntry.transfer(
      Money.new(amount),
      :from => receivables,
      :to   => sales,
      :code => :membership,
      :metadata => {:start => params[:start], :stop => params[:stop]}
    )
  end
end
