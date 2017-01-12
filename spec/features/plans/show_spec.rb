include Warden::Test::Helpers
Warden.test_mode!

# Feature: show plan
#   As a user
#   I want to login
#   So I can see plan details
feature 'Show plan', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can show a plan' do
    user = FactoryGirl.create(:admin)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit plan_path(plan)
    expect(page).to have_content("MyString")
  end

  scenario 'officer can show plan details' do
    user = FactoryGirl.create(:officer)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit plan_path(plan)
    expect(page).to have_content("MyString")
  end

  scenario 'host can show a plan' do
    user = FactoryGirl.create(:host)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit plan_path(plan)
    expect(page).to have_content("MyString")
  end

  scenario 'user cannot show a plan' do
    user = FactoryGirl.create(:user)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit plan_path(plan)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'user not signed in cannot show a plan'  do
    plan = FactoryGirl.create(:plan)
    visit plan_path(plan)
    expect(page).to have_content("You need to sign in")
  end

end
