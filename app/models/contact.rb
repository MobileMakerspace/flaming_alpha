class Contact < ApplicationRecord
  has_many :memberships

  scope :members, -> { joins(:memberships).where('contacts.id is not null').group('contacts.id') }

end
