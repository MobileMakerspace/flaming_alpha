class PaypalWebhook < ApplicationRecord
  serialize :notification_params, Hash
  belongs_to :user


end
