require 'double_entry'

DoubleEntry.configure do |config|
  config.define_accounts do |accounts|
    user_scope = accounts.active_record_scope_identifier(User)
    accounts.define(:identifier => :accounts_receivable,  :scope_identifier => user_scope)
    accounts.define(:identifier => :cash )
    accounts.define(:identifier => :sales_revenue)
    accounts.define(:identifier => :refunds_accounts_receivable)
  end

  config.define_transfers do |transfers|
    transfers.define(:from => :accounts_receivable, :to => :sales_revenue, :code => :membership)
    transfers.define(:from => :accounts_receivable, :to => :sales_revenue, :code => :manual_invoice)
    transfers.define(:from => :cash, :to => :accounts_receivable, :code => :payment)
    transfers.define(:from => :sales_revenue, :to => :accounts_receivable, :code => :credit_note)
    transfers.define(:from => :accounts_receivable, :to => :refunds_accounts_receivable, :code => :customer_refund)
  end
end
