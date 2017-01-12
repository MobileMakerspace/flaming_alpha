class CreditNote < InvoicingLedgerItem                   # Base class for all types of credit note
  acts_as_ledger_item :subtype => :credit_note
end
