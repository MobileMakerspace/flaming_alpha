include Warden::Test::Helpers
Warden.test_mode!

# Feature: list memberships
#   As a user
#   I want to login
#   So I can visit the membership list
feature 'List memberships', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can list memberships' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit memberships_path()
    expect(page).to have_content("Memberships")
  end

  scenario 'host can list memberships' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit memberships_path()
    expect(page).to have_content("Memberships")
  end
    scenario 'officer can list memberships'do
      user = FactoryGirl.create(:officer)
      login_as(user, :scope => :user)
      visit memberships_path()
      expect(page).to have_content("Memberships")
    end

  # Scenario:
  scenario 'user cannot list memberships if not signed in' do
    visit memberships_path()
    expect(page).to have_content("You need to sign in")
  end



end
