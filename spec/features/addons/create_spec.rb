include Warden::Test::Helpers
Warden.test_mode!

# Feature: create addons
#   As a user
#   I want to login
#   So I can create a addon
feature 'Create Addon', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create addons' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit new_addon_path()
    fill_in 'Name', :with => 'Full'
    fill_in 'Price', :with => '50.00'
    click_button 'Create Addon'
    expect(page).to have_content("Addon was successfully created")
  end

  scenario 'host cannot create addons' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit new_addon_path()
    expect(page).to have_content("You are not authorized to perform this action")
  end

  scenario 'officer cannot create contacts' do
    user = FactoryGirl.create(:officer)
    login_as(user, :scope => :user)
    visit new_addon_path()
    expect(page).to have_content("You are not authorized to perform this action")
end

  # Scenario:
  scenario 'user cannot add contacts if not signed in' do
    visit addons_path()
    expect(page).to have_content("You need to sign in")
  end



end
