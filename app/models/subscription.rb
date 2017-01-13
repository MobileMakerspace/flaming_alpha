class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates_presence_of :user
  validates_presence_of :plan
end
