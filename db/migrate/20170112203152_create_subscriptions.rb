class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :plan, index: true
      t.date :start
      t.date :stop

      t.timestamps
    end
  end
end
