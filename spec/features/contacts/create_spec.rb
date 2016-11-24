include Warden::Test::Helpers
Warden.test_mode!

# Feature: create contacts
#   As a user
#   I want to login
#   So I can create a contact
feature 'Create Contact', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create contacts' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit new_contact_path()
    fill_in 'Name', :with => 'New User'
    fill_in 'Emergency name', :with => 'Jane Doe'
    fill_in 'Emergency phone', :with => '555-1212'
    fill_in 'Phone', :with => '123-4567'
    click_button 'Create Contact'
    expect(page).to have_content("Contact was successfully created")
  end

  scenario 'host cannot create contacts' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit new_contact_path()
    expect(page).to have_content("You are not authorized to perform this action")
  end

  scenario 'officer can create contacts' do
    user = FactoryGirl.create(:officer)
    login_as(user, :scope => :user)
    visit new_contact_path()
    fill_in 'Name', :with => 'New User'
    fill_in 'Emergency name', :with => 'Jane Doe'
    fill_in 'Emergency phone', :with => '555-1212'
    fill_in 'Phone', :with => '123-4567'
    click_button 'Create Contact'
    expect(page).to have_content("Contact was successfully created")
end

  # Scenario:
  scenario 'user cannot add contacts if not signed in' do
    visit contacts_path()
    expect(page).to have_content("You need to sign in")
  end



end
