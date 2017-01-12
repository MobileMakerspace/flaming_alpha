class Invoice < InvoicingLedgerItem                      # Base class for all types of invoice
  acts_as_ledger_item :subtype => :invoice
end
