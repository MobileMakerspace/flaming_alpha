class AddFieldsToPaymentNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_notifications, :applied, :boolean, null: false, default: false
    add_reference :payment_notifications, :user, index: true
  end
end
