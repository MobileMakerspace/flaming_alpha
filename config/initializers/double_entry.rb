require 'double_entry'

DoubleEntry.configure do |config|
  config.define_accounts do |accounts|
    contact_scope = accounts.active_record_scope_identifier(Contact)
    accounts.define(:identifier => :accounts_receivable,  :scope_identifier => contact_scope)
    accounts.define(:identifier => :cash )
    accounts.define(:identifier => :sales_revenue)
  end

  config.define_transfers do |transfers|
    transfers.define(:from => :accounts_receivable, :to => :sales_revenue, :code => :membership)
    transfers.define(:from => :cash, :to => :accounts_receivable, :code => :payment)
  end
end
