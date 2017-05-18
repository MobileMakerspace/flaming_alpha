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

  scope :active, -> {
    where("stop IS ?", nil)
  }

  def self.inactive_users
    inactive = Subscription.where('stop is not ?', nil)
    inactive_users =[]
    inactive.each {|x| inactive_users << x.user_id }
    active = Subscription.active
    active_users = []
    active.each {|x| active_users << x.user_id }
    inactive_users - active_users
  end

end
