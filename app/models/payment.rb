class Payment < InvoicingLedgerItem                      # Base class for all types of payment
  acts_as_ledger_item :subtype => :payment
end
