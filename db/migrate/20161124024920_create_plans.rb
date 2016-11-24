class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.boolean :active
      t.integer :interval

      t.timestamps
    end
  end
end
