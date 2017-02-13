include Warden::Test::Helpers
Warden.test_mode!

# Feature: Subscription list
feature 'Subscriber list', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Admin lists subscribers
  #   Given I am signed in
  #   When I visit subscriptions page
  #   Then I see a list of active members
  scenario 'admin lists members' do
    admin = FactoryGirl.create(:admin)
    membership = FactoryGirl.create(:member)
    login_as(admin, :scope => :user)
    visit subscriptions_path()
    expect(page).to have_content(membership.user.name)
    # admin is not a member
    expect(page).not_to have_content(admin.name)
  end


  scenario 'host cannot see a list of subscriber details' do
    host = FactoryGirl.create(:host)
    membership = FactoryGirl.create(:member)
    login_as(host, :scope => :user)
    visit subscriptions_path()
    expect(page).to have_content('not authorized')
  end

  scenario 'officer cannot see a list of subscriber details' do
    officer = FactoryGirl.create(:officer)
    membership = FactoryGirl.create(:member)
    login_as(officer, :scope => :user)
    visit subscriptions_path()
    expect(page).to have_content('not authorized')
  end


  scenario 'user cannot see a list of subscriber details' do
    admin = FactoryGirl.create(:admin)
    membership = FactoryGirl.create(:member)
    login_as(membership.user, :scope => :user)
    visit subscriptions_path()
    expect(page).to have_content('not authorized')
  end

  scenario 'visitor cannot see a list of subscriber details' do
    visit subscriptions_path()
    expect(page).to have_content("You need to sign in")
  end

end
