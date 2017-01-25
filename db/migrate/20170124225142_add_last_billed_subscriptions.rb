class AddLastBilledSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :last_billed, :date
  end
end
