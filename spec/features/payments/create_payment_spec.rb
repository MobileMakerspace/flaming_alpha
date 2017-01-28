include Warden::Test::Helpers
Warden.test_mode!

feature 'Create payments', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create a payment' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit payment_path(member.id)
    expect(page).to have_content("Ledger")
    fill_in 'Amount', :with => '9999'
    fill_in 'Note', :with => 'cash payment received'
    click_button 'Create Payment'
    expect(page).to have_content("Payment was successfully created")
  end

  scenario 'user can not create payments' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(member, :scope => :user)
    visit payment_path(member.id)
    expect(page).to have_content("You are not authorized")
  end

  # Scenario:
  scenario 'user cannot list plans if not signed in' do
    user = FactoryGirl.create(:admin)
    visit payment_path(user.id)
    expect(page).to have_content("You need to sign in")
  end


end
