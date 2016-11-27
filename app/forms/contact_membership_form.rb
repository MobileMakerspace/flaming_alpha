class ContactMembershipForm
  include ActiveModel::Model
  include Virtus.model

  attribute :name
  attribute :email
  attribute :phone
  attribute :emergency_name
  attribute :emergency_phone
  attribute :addr_1
  attribute :addr_2
  attribute :city
  attribute :state
  attribute :zip
  attribute :start
  attribute :stop
  attribute :plan_id

'''
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :emergency_name, presence: true
  validates :emergency_phone, presence: true
'''
  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    contact = Contact.create!(name: name, email: email, phone: phone, emergency_name: emergency_name, emergency_phone: emergency_phone, addr_1:addr_1,addr_2: addr_2,city: city, state: state, zip:zip)
    @membership = contact.memberships.create(plan: plan_id, start: start, stop: stop)
  end

end
