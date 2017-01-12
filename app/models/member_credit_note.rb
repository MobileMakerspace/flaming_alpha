class MemberCreditNote < CreditNote
  belongs_to :recipient, class_name: 'User', touch: true
  belongs_to :sender, class_name: 'User', touch: true

  # Virtual attribute
  attr_accessor :invoice_id
end
