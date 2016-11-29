include Warden::Test::Helpers
Warden.test_mode!

# Feature: show membership
#   As a user
#   I want to login
#   So I can visit the membership list
feature 'Show memberships', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can show a membership' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:member)
    login_as(user, :scope => :user)
    visit membership_path(member)
    expect(page).to have_content("MyString")
  end

  scenario 'officer can show a membership' do
    user = FactoryGirl.create(:officer)
    member = FactoryGirl.create(:member)
    login_as(user, :scope => :user)
    visit membership_path(member)
    expect(page).to have_content("MyString")
  end

  scenario 'host can show a membership' do
    user = FactoryGirl.create(:host)
    member = FactoryGirl.create(:member)
    login_as(user, :scope => :user)
    visit membership_path(member)
    expect(page).to have_content("MyString")
  end

  scenario 'user cannot show a membership' do
    user = FactoryGirl.create(:user)
    member = FactoryGirl.create(:member)
    login_as(user, :scope => :user)
    visit membership_path(member)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'user not signed in cannot show a membership'  do
    member = FactoryGirl.create(:member)
    visit membership_path(member)
    expect(page).to have_content("You need to sign in")
  end

end
