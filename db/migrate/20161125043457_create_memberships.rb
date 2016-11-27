class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.belongs_to :contact, index: true
      t.belongs_to :plan, index: true
      t.date :start
      t.date :stop

      t.timestamps
    end
  end
end
