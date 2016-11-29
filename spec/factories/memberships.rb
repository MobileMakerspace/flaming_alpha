FactoryGirl.define do
  factory :membership do
    start "2016-11-24"
    stop "2016-11-24"
  end

  factory :member, class: Membership do
    start "2016-11-24"
    stop "2016-11-24"
    association :contact, factory: :contact
    association :plan, factory: :plan
  end
"""
  factory :contact, class: Contact do
    name 'Joe Member'
  end

  factory :plan, class: Plan do
    name 'Full membership'
    price '50.00'
  end
"""
end
