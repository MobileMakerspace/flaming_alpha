FactoryGirl.define do
  factory :invoice do
    amount "5000"
    note "MyText"
    start "2016-11-01"
    stop "2016-11-30"
  end
end
