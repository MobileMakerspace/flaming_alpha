class PaymentNotification < ApplicationRecord
  #attr_accessor :notification_params, :status, :transaction_id, :purchased_at
  serialize :notification_params, Hash
end
