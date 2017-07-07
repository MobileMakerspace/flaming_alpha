class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create] #Otherwise the request from PayPal wouldn't make it to the controller
  before_action :authenticate_user!, :except => [:create]

  # GET /payments
  # GET /payments.json
  def index
    authorize PaymentNotification
    @payment_notifications = PaymentNotification.where(status: "Completed").order(created_at: :desc)
    @paypal_notices = PaymentNotification.where.not(status: "Completed").order(created_at: :desc)
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment_notification = PaymentNotification.find(params[:id])
    authorize @payment_notification
  end

  # GET /payments/1/edit
  def edit
    @payment_notification = PaymentNotification.find(params[:id])
    authorize @payment_notification
  end


  def create
    params.permit! # Permit all Paypal input params
    response = validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      # check that paymentStatus=Completed
      # check that txnId has not been previously processed
      # check that receiverEmail is your Primary PayPal email
      # check that paymentAmount/paymentCurrency are correct
      # process payment

      status = params[:payment_status]
      @payment_notice = PaymentNotification.new(status: status)
      @payment_notice.transaction_id = params[:txn_id]
      @payment_notice.purchased_at = Time.now
      @payment_notice.notification_params = params.to_h
      @payment_notice.save!


    when "INVALID"
      # log for investigation
    else
      # error
    end
    render :nothing => true
  end

  def update
    @payment_notification = PaymentNotification.find(params[:id])
    authorize @payment_notification

    @user = User.find(payment_notification_params[:user][:user_id])
    cn_params = {user_id: @user.id,
      amount: @payment_notification.gross_payment_cents,
      note: "Paypal transaction #{@payment_notification.transaction_id}"
    }

    if AcceptPaymentService.new.call(cn_params)
      @payment_notification.user = @user
      @payment_notification.applied = true
      if @payment_notification.save!
        redirect_to @payment_notification, notice: 'Payment was successfully applied.'
      else
        render :edit
      end
    else
      render :edit
    end
  end


  protected
  def validate_IPN_notification(raw)
    uri = URI.parse(Rails.application.secrets.paypal_ipn_url + '?cmd=_notify-validate')
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, raw,
                         'Content-Length' => "#{raw.size}",
                         'User-Agent' => "My custom user agent"
                       ).body
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_notification_params
    params.permit(user: [:user_id])
  end

end
