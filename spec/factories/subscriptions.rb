FactoryGirl.define do
  factory :subscription do
    start "2016-11-24"
    stop "2016-11-24"
  end

  factory :member, class: Subscription do
    user
    plan
    start "2016-11-24"
    stop nil
  end
  
end
