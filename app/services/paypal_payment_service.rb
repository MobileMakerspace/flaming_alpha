class PaypalPaymentService
  attr_accessor :payment
  
  def initialize(host, amount)
    @payment = PayPal::SDK::REST::Payment.new(data(host, amount))
  end

  def accept
    @payment.create
  end

  def response
    @payment
  end

  private

  def data(host, amount)
    {
      intent: 'sale',
      payer: {
        payment_method: 'paypal' },
      redirect_urls: {
        return_url: host + '/done',
        cancel_url: host + '/cancel' },
      transactions: [ {
        amount: {
          total: amount,
          currency: 'USD' },
        description: 'membership invoice' } ]
    }
  end
end
