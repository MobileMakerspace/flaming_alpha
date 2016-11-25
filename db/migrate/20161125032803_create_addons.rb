class CreateAddons < ActiveRecord::Migration[5.0]
  def change
    create_table :addons do |t|
      t.string :name
      t.decimal :price
      t.boolean :active, default: :false
      t.boolean :authrequired, default: :true

      t.timestamps
    end
  end
end
