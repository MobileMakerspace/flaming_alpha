include Warden::Test::Helpers
Warden.test_mode!

# Feature: show addon
#   As a user
#   I want to login
#   So I can see addon details
feature 'Show addon', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can show a addon' do
    user = FactoryGirl.create(:admin)
    addon = FactoryGirl.create(:addon)
    login_as(user, :scope => :user)
    visit addon_path(addon)
    expect(page).to have_content("MyString")
  end

  scenario 'officer can show addon details' do
    user = FactoryGirl.create(:officer)
    addon = FactoryGirl.create(:addon)
    login_as(user, :scope => :user)
    visit addon_path(addon)
    expect(page).to have_content("MyString")
  end

  scenario 'host can show a addon' do
    user = FactoryGirl.create(:host)
    addon = FactoryGirl.create(:addon)
    login_as(user, :scope => :user)
    visit addon_path(addon)
    expect(page).to have_content("MyString")
  end

  scenario 'user cannot show a addon' do
    user = FactoryGirl.create(:user)
    addon = FactoryGirl.create(:addon)
    login_as(user, :scope => :user)
    visit addon_path(addon)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'user not signed in cannot show a addon'  do
    addon = FactoryGirl.create(:addon)
    visit addon_path(addon)
    expect(page).to have_content("You need to sign in")
  end

end
