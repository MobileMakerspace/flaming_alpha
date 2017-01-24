class ChangePriceToMonetize < ActiveRecord::Migration[5.0]
  def up
      remove_column :plans, :price, :decimal
      add_monetize :plans, :price
  end

  def down
      remove_monetize :plans, :price
      add_column :plans, :price, :decimal
  end
end
