class CreatePaymentNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_notifications do |t|
      t.text :notification_params
      t.string :status
      t.string :transaction_id
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
