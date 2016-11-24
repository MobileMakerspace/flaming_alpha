include Warden::Test::Helpers
Warden.test_mode!

# Feature: show contact
#   As a user
#   I want to login
#   So I can visit the contact list
feature 'Show', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can show a contact' do
    user = FactoryGirl.create(:admin)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit contact_path(contact)
    expect(page).to have_content("MyString")
  end

  scenario 'officer can show a contact' do
    user = FactoryGirl.create(:officer)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit contact_path(contact)
    expect(page).to have_content("MyString")
  end

  scenario 'host can show a contact' do
    user = FactoryGirl.create(:host)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit contact_path(contact)
    expect(page).to have_content("MyString")
  end

  scenario 'user cannot show a contact' do
    user = FactoryGirl.create(:user)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit contact_path(contact)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'user not signed in cannot show a contact'  do
    visit contacts_path()
    expect(page).to have_content("You need to sign in")
  end

end
