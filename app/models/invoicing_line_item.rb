class InvoicingLineItem < ActiveRecord::Base
  acts_as_line_item

  belongs_to :ledger_item, class_name: 'InvoicingLedgerItem'

  def net_amount
      q = quantity || 0
  	  up = unit_price || 0
  	  return q * up
  end

end
