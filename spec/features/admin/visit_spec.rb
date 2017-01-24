include Warden::Test::Helpers
Warden.test_mode!

# Feature: Admin can access admin interface
#   As a user
#   I want to login
#   So I can visit the admin interface
feature 'Visit admin interface', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can visit admin interface' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit admin_root_path()
    expect(page).to have_content("Plans")
  end

  scenario 'user cannot visit admin interface' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit admin_root_path()
    expect(page).to have_content("You are not authorized")
  end

  scenario 'vip cannot visit admin interface' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit admin_root_path()
    expect(page).to have_content("You are not authorized")
  end

  scenario 'officer cannot visit admin interface' do
    user = FactoryGirl.create(:officer)
    login_as(user, :scope => :user)
    visit admin_root_path()
    expect(page).to have_content("You are not authorized")
  end

  scenario 'user not signed in cannot show a contact'  do
    visit admin_root_path()
    expect(page).to have_content("You need to sign in")
  end

end
