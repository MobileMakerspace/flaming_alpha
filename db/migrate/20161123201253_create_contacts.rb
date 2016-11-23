class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :emergency_name
      t.string :emergency_phone
      t.string :addr_1
      t.string :addr_2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
