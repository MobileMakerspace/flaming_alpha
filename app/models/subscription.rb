class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates_presence_of :user
  validates_presence_of :plan

  # There is a locking issue with using after_create
  # and double_entry.
  # after_create do |subscription|
  #   params = {subscription_id: subscription.id}
  #   BillMembershipService.new.first_bill(params)
  # end

end
