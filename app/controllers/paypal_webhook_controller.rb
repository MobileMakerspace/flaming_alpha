class PaypalWebhookController < ApplicationController
 protect_from_forgery :except => [:webhook] #Otherwise the request from PayPal wouldn't make it to the controller
 before_action :authenticate_user!, :except => [:webhook]

  def webhook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    actual_sig = request.headers["HTTP_PAYPAL_TRANSMISSION_SIG"]
    auth_algo =  request.headers["HTTP_PAYPAL_AUTH_ALGO"]
    auth_algo = "sha256"
    cert_url = request.headers["HTTP_PAYPAL_CERT_URL"]
    transmission_id = request.headers["HTTP_PAYPAL_TRANSMISSION_ID"]
    timestamp = request.headers["HTTP_PAYPAL_TRANSMISSION_TIME"]
    webhook_id = ENV['PP_WEBHOOK_ID'] #The webhook_id provided by PayPal when webhook is created on the PayPal developer site
    #event_body = params["payment"].to_json
    event_body = params.to_json

    valid = PayPal::SDK::REST::WebhookEvent.verify(transmission_id, timestamp, webhook_id, event_body, cert_url, actual_sig, auth_algo)

    if valid
      logger.info "webhook event #{webhook_id} has been verified"
    else
      logger.info "webhook event #{webhook_id} validation failed"
    end
    # t.text :notification_params
    # t.string :status
    # t.string :event_verify_status
    # t.string :event_id
    # t.datetime :purchased_at
    # t.string :summary

    status = params[:payment_status]
    @payment_notice = PaypalWebhook.new(status: status)
    @payment_notice.event_verify_status = valid
    @payment_notice.event_id = params[:id]
    @payment_notice.purchased_at = Time.now
    @payment_notice.notification_params = params.to_h
    @payment_notice.save!


    render :nothing => true
  end

end
