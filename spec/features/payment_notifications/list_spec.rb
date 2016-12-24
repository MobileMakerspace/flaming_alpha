include Warden::Test::Helpers
Warden.test_mode!

# Feature: list payment_notifications
#   As a user
#   I want to login
#   So I can visit the payment_notification list
feature 'List payment_notifications', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can list payment_notifications' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit payment_notifications_path()
    expect(page).to have_content("Payments")
  end

  scenario 'host cannot list payment_notifications' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit payment_notifications_path()
    expect(page).to have_content("You are not authorized")
  end
    scenario 'officer cannot list payment_notifications'do
      user = FactoryGirl.create(:officer)
      login_as(user, :scope => :user)
      visit payment_notifications_path()
      expect(page).to have_content("You are not authorized")
    end

    scenario 'user cannot list payment_notifications'do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      visit payment_notifications_path()
      expect(page).to have_content("You are not authorized")
    end

  # Scenario:
  scenario 'user cannot list payment_notifications if not signed in' do
    visit payment_notifications_path()
    expect(page).to have_content("You need to sign in")
  end



end
