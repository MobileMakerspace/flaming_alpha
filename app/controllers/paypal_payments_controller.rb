class PaypalPaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    amount = Money.from_amount(detail[:paypal_payment][:amount].to_d,'USD')
    @payment = PaypalPaymentService.new(get_host, amount) #detail[:amount])
    if @payment.accept
      redirect_to extract_link(@payment.response)
    else
      redirect_to root_path, notice: 'something went wrong '
    end
  end

  def done
    @current_user = current_user
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
    payment.execute(payer_id: params[:PayerID])
    pp payment
    @amount = payment.transactions.first.amount.total
    @description = payment.transactions.first.description
    save_record(payment, @current_user)
  end

  def cancel
    redirect_to '/', notice: 'You canceled payment'
  end

  private

  def detail
    params.permit(:id, paypal_payment: [:note, :amount])
  end

  def get_host
    request.base_url
  end

  def extract_link(data)
    #data.links.find { |link| link.rel == 'approval_url' }.href
    data.approval_url(true)
  end

  def save_record(payment, user)
    payer = payment.payer.payer_info
    full_name = payer.first_name + ' ' + payer.last_name
    description = payment.transactions.first.description
    amount = payment.transactions.first.amount.total
    amount = Money.from_amount(amount.to_d,'USD')
    attributes = payment_structure(description, amount, full_name, payment.create_time)
    cn_params = {user_id: user.id,
      amount: amount,
      note: "#{full_name} : #{description}"
    }

    AcceptPaymentService.new.call(cn_params)
    #Payment.create attributes
  end

  def payment_structure(concern, amount, payer, paid_at)
    {
      concern: concern,
      amount: amount,
      payer: payer,
      paid_at: paid_at
    }
  end
end
