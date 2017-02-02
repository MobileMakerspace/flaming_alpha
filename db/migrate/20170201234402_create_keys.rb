class CreateKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :keys do |t|
      t.belongs_to :user, index: true
      t.string :identifier
      t.date :assigned
      t.date :returned

      t.timestamps
    end
  end
end
