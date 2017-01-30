FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "John Smith"
    email "buyer@paypalsandbox.com"
    password "please123"

  end

  factory :host, class: User do
    confirmed_at Time.now
    name "Joe Host"
    email "host@example.com"
    password "please123"
    role 'host'
  end

  factory :admin, class: User do
    confirmed_at Time.now
    name "Admin Johnny"
    email "host@example.com"
    password "please123"
    role 'admin'
  end

  factory :officer, class: User do
    confirmed_at Time.now
    name "President Cesar"
    email "President@example.com"
    password "please123"
    role 'officer'
  end

end
