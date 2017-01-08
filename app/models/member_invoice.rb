class MemberInvoice < Invoice
  belongs_to :recipient, class_name: 'Contact'
  belongs_to :sender, class_name: 'Contact'
    
end
