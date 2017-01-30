include Warden::Test::Helpers
Warden.test_mode!

# Feature: apply payment_notifications to accounts
feature 'Apply payment_notifications', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can manually apply payment_notification' do
    admin = FactoryGirl.create(:admin)
    user = FactoryGirl.create(:user)
    payment = FactoryGirl.create(:payment_notification)
    login_as(admin, :scope => :user)
    visit payment_notifications_path()
    expect(page).to have_content(payment.transaction_id)
    visit edit_payment_notification_path(payment)
    payment_user = "#{payment.notification_params['first_name']} #{payment.notification_params['last_name']}"
    select payment_user, :from => "user_user_id"
    click_button 'Apply Payment'
    expect(page).to have_content("Payment was successfully applied")
  end

  scenario 'user cannot access the edit payment_notifcations page' do
    user = FactoryGirl.create(:user)
    payment = FactoryGirl.create(:payment_notification)
    login_as(user, :scope => :user)
    visit edit_payment_notification_path(payment)
    expect(page).to have_content("not authorized")

  end

  # Scenario:
  scenario 'user cannot list payment_notifications if not signed in' do
    visit payment_notifications_path()
    expect(page).to have_content("You need to sign in")
  end



end
