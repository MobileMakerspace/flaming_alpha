include Warden::Test::Helpers
Warden.test_mode!

# Feature: show payment_notification
#   As a user
#   I want to login
#   So I can see payment_notification details
feature 'Show payment_notification', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can show a payment_notification' do
    user = FactoryGirl.create(:admin)
    payment_notification = FactoryGirl.create(:payment_notification)
    login_as(user, :scope => :user)
    visit payment_notification_path(payment_notification)
    expect(page).to have_content("7P991219RJ017861X")
  end

  scenario 'officer cannot show payment_notification details' do
    user = FactoryGirl.create(:officer)
    payment_notification = FactoryGirl.create(:payment_notification)
    login_as(user, :scope => :user)
    visit payment_notification_path(payment_notification)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'host cannot show a payment_notification' do
    user = FactoryGirl.create(:host)
    payment_notification = FactoryGirl.create(:payment_notification)
    login_as(user, :scope => :user)
    visit payment_notification_path(payment_notification)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'user cannot show a payment_notification' do
    user = FactoryGirl.create(:user)
    payment_notification = FactoryGirl.create(:payment_notification)
    login_as(user, :scope => :user)
    visit payment_notification_path(payment_notification)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'user not signed in cannot show a payment_notification'  do
    payment_notification = FactoryGirl.create(:payment_notification)
    visit payment_notification_path(payment_notification)
    expect(page).to have_content("You need to sign in")
  end

end
