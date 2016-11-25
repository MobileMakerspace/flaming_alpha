include Warden::Test::Helpers
Warden.test_mode!

# Feature: Update addons
#   As a user
#   I want to login
#   So I can update a addon
feature 'Update addons', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can update addons' do
    user = FactoryGirl.create(:admin)
    addon = FactoryGirl.create(:addon)
    login_as(user, :scope => :user)
    visit edit_addon_path(addon)
    fill_in "Name", :with => 'New Name'
    click_button 'Update Addon'
    expect(page).to have_content("Addon was successfully updated")
    expect(page).to have_content('New Name')
  end

  scenario 'host cannot update addons' do
    user = FactoryGirl.create(:host)
    addon = FactoryGirl.create(:addon)
    login_as(user, :scope => :user)
    visit edit_addon_path(addon)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'officer can create addons'  do
    user = FactoryGirl.create(:officer)
    addon = FactoryGirl.create(:addon)
    login_as(user, :scope => :user)
    visit edit_addon_path(addon)
    visit edit_addon_path(addon)
    expect(page).to have_content("You are not authorized")
  end

  # Scenario:
  scenario 'user cannot update addons if not signed in' do
    addon = FactoryGirl.create(:addon)
    visit edit_addon_path(addon)
    expect(page).to have_content("You need to sign in")
  end



end
