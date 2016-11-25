include Warden::Test::Helpers
Warden.test_mode!

# Feature: list addons
#   As a user
#   I want to login
#   So I can visit the addon list
feature 'List addons', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can list addons' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit addons_path()
    expect(page).to have_content("Addons")
  end

  scenario 'host can list addons' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit addons_path()
    expect(page).to have_content("Addons")
  end
    scenario 'officer can list addons'do
      user = FactoryGirl.create(:officer)
      login_as(user, :scope => :user)
      visit addons_path()
      expect(page).to have_content("Addons")
    end

  # Scenario:
  scenario 'user cannot list addons if not signed in' do
    visit addons_path()
    expect(page).to have_content("You need to sign in")
  end



end
