FactoryGirl.define do
  factory :payment_notification do
    notification_params "MyText"
    status "MyString"
    transaction_id "MyString"
    purchased_at "2016-12-19 04:15:21"
  end
end
