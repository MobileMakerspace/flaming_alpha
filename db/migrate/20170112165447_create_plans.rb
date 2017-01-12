class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.boolean :active
      t.boolean :approval_needed

      t.timestamps
    end
  end
end
