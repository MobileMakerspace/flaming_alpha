include Warden::Test::Helpers
Warden.test_mode!

# Feature: User list
#   As a admin
#   I want to list users
feature 'User list', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Admin lists users
  #   Given I am signed in
  #   When I visit users page
  #   Then I see a list of users
  scenario 'admin lists users' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)
    login_as(admin, :scope => :user)
    visit users_path()
    expect(page).to have_content(user.name)
    expect(page).to have_content(admin.name)
  end

  pending 'visitor cannot see a list of users'
  pending 'user cannot see a list of users'

end
