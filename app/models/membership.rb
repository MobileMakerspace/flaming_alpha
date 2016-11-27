class Membership < ApplicationRecord
  #attr_accessor :contact_id
  belongs_to :contact
  belongs_to :plan
end
