include Warden::Test::Helpers
Warden.test_mode!

# Feature: create plans
#   As a user
#   I want to login
#   So I can create a plan
feature 'Create Plan', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create plans' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit new_plan_path()
    fill_in 'Name', :with => 'Full'
    fill_in 'Price', :with => '50.00'
    click_button 'Create Plan'
    expect(page).to have_content("Plan was successfully created")
  end

  scenario 'host cannot create plans' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit new_plan_path()
    expect(page).to have_content("You are not authorized to perform this action")
  end

  scenario 'officer cannot create plans' do
    user = FactoryGirl.create(:officer)
    login_as(user, :scope => :user)
    visit new_plan_path()
    expect(page).to have_content("You are not authorized to perform this action")
  end

  scenario 'user cannot create plans' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_plan_path()
    expect(page).to have_content("You are not authorized to perform this action")
  end

  # Scenario:
  scenario 'user cannot add plans if not signed in' do
    visit plans_path()
    expect(page).to have_content("You need to sign in")
  end



end
