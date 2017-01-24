FactoryGirl.define do
  factory :plan do
    name "MyString"
    price "5000"
    description "MyText"
    active false
    approval_needed false
  end
end
