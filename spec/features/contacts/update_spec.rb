include Warden::Test::Helpers
Warden.test_mode!

# Feature: Update contacts
#   As a user
#   I want to login
#   So I can create a contact
feature 'Update contacts', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can update contacts' do
    user = FactoryGirl.create(:admin)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit edit_contact_path(contact)
    fill_in "Emergency name", :with => 'Jane Doe'
    click_button 'Update Contact'
    expect(page).to have_content("Contact was successfully updated")
    expect(page).to have_content('Jane Doe')
  end

  scenario 'host cannot update contacts' do
    user = FactoryGirl.create(:host)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit edit_contact_path(contact)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'officer can create contacts'  do
    user = FactoryGirl.create(:officer)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit edit_contact_path(contact)
    fill_in "Emergency name", :with => 'Jane Doe'
    click_button 'Update Contact'
    expect(page).to have_content("Contact was successfully updated")
    expect(page).to have_content('Jane Doe')
  end

  # Scenario:
  scenario 'user cannot update contacts if not signed in' do
    visit contacts_path()
    expect(page).to have_content("You need to sign in")
  end



end
