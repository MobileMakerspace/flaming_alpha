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
    expect(page).to have_content("Memberships")
  end

  scenario 'user cannot visit admin interface' do
    user = FactoryGirl.create(:user)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit admin_root_path()
    expect(page).to have_content("You are not authorized")
  end

  scenario 'vip cannot visit admin interface' do
    user = FactoryGirl.create(:host)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit admin_root_path()
    expect(page).to have_content("You are not authorized")
  end

  scenario 'officer cannot visit admin interface' do
    user = FactoryGirl.create(:officer)
    contact = FactoryGirl.create(:contact)
    login_as(user, :scope => :user)
    visit admin_root_path()
    expect(page).to have_content("You are not authorized")
  end

  scenario 'user not signed in cannot show a contact'  do
    visit admin_root_path()
    expect(page).to have_content("You need to sign in")
  end

end
