include Warden::Test::Helpers
Warden.test_mode!

# Feature: Stop subscription
#   As a admin
#   I want to login
#   So I can stop a user's subscription
feature 'Stop Subscription', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can stop a subscription' do
    user = FactoryGirl.create(:admin)
    user2 = FactoryGirl.create(:user)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit new_subscription_path()
    select "#{user2.name}", :from => "subscription_user_id"
    select "#{plan.name}", :from => "subscription_plan_id"
    click_button 'Create Subscription'
    expect(page).to have_content("Subscription was successfully created")
    visit subscriptions_path()
    visit account_path(user2)
    click_link 'Edit'
    expect(page).to have_content("")
    #fill_in 'Stop', :with => Date.today.at_end_of_month
    select_date(Date.today.at_end_of_month, from: 'subscription_stop')
    click_button 'Update'
    expect(page).to have_content("Subscription was successfully updated")
  end


end
