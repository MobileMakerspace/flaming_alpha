class InvoicingLedgerItem < ActiveRecord::Base
  acts_as_ledger_item

  has_many :line_items, class_name: 'InvoicingLineItem', foreign_key: :ledger_item_id
  accepts_nested_attributes_for :line_items
end
