include Warden::Test::Helpers
Warden.test_mode!

# Feature: create subscription
#   As a user
#   I want to login
#   So I can create a subscription
feature 'Create Subscription', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create a subscription' do
    user = FactoryGirl.create(:admin)
    user2 = FactoryGirl.create(:user)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit new_subscription_path()
    select "#{user2.name}", :from => "subscription_user_id"
    select "#{plan.name}", :from => "subscription_plan_id"
    click_button 'Create Subscription'
    expect(page).to have_content("Subscription was successfully created")
  end

  scenario 'user can create a subscription using this path' do
    user = FactoryGirl.create(:admin)
    user2 = FactoryGirl.create(:user)
    plan = FactoryGirl.create(:plan)
    login_as(user2, :scope => :user)
    visit new_subscription_path()
    select "#{plan.name}", :from => "subscription_plan_id"
    click_button 'Create Subscription'
    expect(page).to have_content("Subscription was successfully created")  end

  scenario 'visitor cannot access path if not signed in' do
    visit new_subscription_path()
    expect(page).to have_content("You need to sign in")
  end

end
