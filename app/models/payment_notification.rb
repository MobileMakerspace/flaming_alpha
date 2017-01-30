class PaymentNotification < ApplicationRecord
  #attr_accessor :notification_params, :status, :transaction_id, :purchased_at
  serialize :notification_params, Hash
  belongs_to :user

  def name()
    "#{self.notification_params["first_name"]} #{self.notification_params["last_name"]}"
  end

  def email()
    "#{self.notification_params["buyer_email"]}"
  end

  def gross_payment_cents()
    amount = self.notification_params["mc_gross"]
    amount = amount.to_i * 100
    amount
  end

end
