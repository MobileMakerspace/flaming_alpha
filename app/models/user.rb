class User < ApplicationRecord
  enum role: [:user, :host,:officer, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :subscriptions
  has_many :payment_notifications

  # Collection of all ledger items for this member
  has_many :ledger_items, :foreign_key => 'recipient_id', class_name: 'InvoicingLedgerItem'

  # Collections of ledger items by type.
  has_many :member_invoices, :foreign_key => 'recipient_id', class_name: 'MemberInvoice'
  has_many :member_payments, :foreign_key => 'recipient_id', class_name: 'MemberPayment'
  has_many :member_credit_notes, :foreign_key => 'recipient_id', class_name: 'MemberCreditNote'

  has_one :key

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
        :recoverable, :rememberable, :trackable, :validatable

  def balance
    DoubleEntry.account(:accounts_receivable, :scope => self).balance
  end
end
