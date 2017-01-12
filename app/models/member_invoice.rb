class MemberInvoice < Invoice
  belongs_to :recipient, class_name: 'User', touch: true
  belongs_to :sender, class_name: 'User', touch: true
end
