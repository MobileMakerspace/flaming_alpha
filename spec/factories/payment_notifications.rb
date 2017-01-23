FactoryGirl.define do
  payment_hash = {"payment_type"=>"instant", "payment_date"=>"Mon Dec 19 2016 12:08:07 GMT-0600 (CST)", "payment_status"=>"Completed", "payer_status"=>"verified", "first_name"=>"John", "last_name"=>"Smith", "payer_email"=>"buyer@paypalsandbox.com", "payer_id"=>"TESTBUYERID01", "address_name"=>"John Smith", "address_country"=>"United States", "address_country_code"=>"US", "address_zip"=>"95131", "address_state"=>"CA", "address_city"=>"San Jose", "address_street"=>"123 any street", "business"=>"seller@paypalsandbox.com", "receiver_email"=>"seller@paypalsandbox.com", "receiver_id"=>"seller@paypalsandbox.com", "residence_country"=>"US", "item_name1"=>"something", "item_number1"=>"AK-1234", "quantity"=>"1", "shipping"=>"3.04", "tax"=>"2.02", "mc_currency"=>"USD", "mc_fee"=>"0.44", "mc_gross"=>"12.34", "mc_gross_1"=>"12.34", "mc_handling"=>"2.06", "mc_handling1"=>"1.67", "mc_shipping"=>"3.02", "mc_shipping1"=>"1.02", "txn_type"=>"cart", "txn_id"=>"899327589", "notify_version"=>"2.4", "custom"=>"xyz123", "invoice"=>"abc1234", "test_ipn"=>"1", "verify_sign"=>"AFcWxV21C7fd0v3bYYYRCpSSRl31AMI-jg3rKTqlbTVkF9jE1bYrXOzN", "controller"=>"payment_notifications", "action"=>"create"}
  factory :payment_notification do
    notification_params payment_hash
    status "Completed"
    transaction_id "7P991219RJ017861X"
    purchased_at "2016-12-19 04:15:21"
  end
end
