class BillMembershipService
  def call(params)
    invoice = MemberInvoice.new
    invoice.recipient_id = params[:user_id]
    invoice.currency = 'usd'

    # add line items
    quantity = params[:quantity] # 1 is a month, use decimals pro-rating
    plan = Plan.find(params[:plan_id]) # TODO figure out which plan we're billing for
    invoice.line_items.build(description: plan.name, unit_price: plan.price, quantity: quantity)
    # ... add line_items to the invoice as needed

    invoice.save
  end
end
