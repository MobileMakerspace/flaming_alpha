include Warden::Test::Helpers
Warden.test_mode!

# Feature: list contacts
#   As a user
#   I want to login
#   So I can visit the contact list
feature 'List', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can list contacts' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit contacts_path()
    expect(page).to have_content("Contacts")
  end

  scenario 'host can list contacts' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit contacts_path()
    expect(page).to have_content("Contacts")
  end
    scenario 'officer can list contacts'do
      user = FactoryGirl.create(:officer)
      login_as(user, :scope => :user)
      visit contacts_path()
      expect(page).to have_content("Contacts")
    end

  # Scenario:
  scenario 'user cannot list contacts if not signed in' do
    visit contacts_path()
    expect(page).to have_content("You need to sign in")
  end



end
