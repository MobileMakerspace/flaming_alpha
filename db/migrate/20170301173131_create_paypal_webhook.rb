class CreatePaypalWebhook < ActiveRecord::Migration[5.0]
  def change
    create_table :paypal_webhooks do |t|

      t.text :notification_params
      t.string :status
      t.string :event_verify_status
      t.string :event_id
      t.datetime :purchased_at
      t.string :summary

    end
  end
end
