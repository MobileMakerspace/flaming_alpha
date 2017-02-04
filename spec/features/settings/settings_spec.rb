include Warden::Test::Helpers
Warden.test_mode!

# Feature: Setting management
#   As a admin
#   I want to manage application settings
feature 'List keys', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Admin accesses settings
  #   Given I am signed in as an admin
  #   When I visit settings page
  #   Then I see a list of application settings
  scenario 'admin lists users with keys' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)

    login_as(admin, :scope => :user)
    visit settings_path()
    expect(page).to have_content('Key')
  end

  scenario 'visitor cannot see a application settings' do
    visit settings_path()
    expect(page).to have_content("You need to sign in")
  end

  scenario 'user cannot see a list of keys' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit settings_path()
    expect(page).to have_content("not authorized")
  end

end
