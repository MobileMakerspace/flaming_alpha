include Warden::Test::Helpers
Warden.test_mode!

# Feature: Key management
#   As a admin
#   I want to manage keys assigned to users
feature 'List keys', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Admin sees who has a key
  #   Given I am signed in as an admin
  #   When I visit key management page
  #   Then I see a list of users with a key
  scenario 'admin lists users with keys' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)

    login_as(admin, :scope => :user)
    visit keys_path()
    expect(page).to have_content('Keys')
  end

  scenario 'visitor cannot see a list of keys' do
    visit keys_path()
    expect(page).to have_content("You need to sign in")
  end

  scenario 'user cannot see a list of keys' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit keys_path()
    expect(page).to have_content("not authorized")
  end

end
