include Warden::Test::Helpers
Warden.test_mode!

# Feature: Key management
#   As a admin
#   I want to assign key to users
feature 'Assign keys', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Admin assigns a key
  #   Given I am signed in as an admin
  #   When I visit key management page
  #   I see a button to assign a key
  #   I select a user and assign the key
  scenario 'admin assigns key to user' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)
    key = FactoryGirl.create(:key)
    login_as(admin, :scope => :user)
    visit keys_path()
    expect(page).to have_content('Assign Key')
    click_link 'Assign Key'
    select "#{user.name}", :from => "key_user_id"
    click_button 'Assign'
    expect(page).to have_content('Key was successfully updated')
    expect(page).to have_content(user.name)
  end

  scenario 'admin returns key from user' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)
    key = FactoryGirl.create(:key)
    login_as(admin, :scope => :user)
    visit keys_path()
    expect(page).to have_content('Assign Key')
    click_link 'Assign Key'
    select "#{user.name}", :from => "key_user_id"
    click_button 'Assign'
    expect(page).to have_content('Key was successfully updated')
    visit keys_path()
    click_link 'Return Key'
    click_button 'Return Key'
    expect(page).to have_content('Key was successfully updated')
    visit keys_path()
    expect(page).to have_content('Assign Key')
  end

end
