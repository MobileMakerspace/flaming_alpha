class AddFieldsToInvoicingLineItems < ActiveRecord::Migration[5.0]
  def change
    add_column :invoicing_line_items, :tax_rate, :decimal, precision: 8, scale: 4
    add_column :invoicing_line_items, :unit_price, :decimal, precision: 20, scale: 4
  end
end
