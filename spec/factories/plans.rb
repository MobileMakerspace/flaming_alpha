FactoryGirl.define do
  factory :plan do
    name "MyString"
    price "9.99"
    description "MyText"
    active false
    approval_needed false
  end
end
