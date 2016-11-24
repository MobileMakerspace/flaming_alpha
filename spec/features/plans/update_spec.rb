include Warden::Test::Helpers
Warden.test_mode!

# Feature: Update plans
#   As a user
#   I want to login
#   So I can update a plan
feature 'Update plans', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can update plans' do
    user = FactoryGirl.create(:admin)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit edit_plan_path(plan)
    fill_in "Name", :with => 'New Name'
    click_button 'Update Plan'
    expect(page).to have_content("Plan was successfully updated")
    expect(page).to have_content('New Name')
  end

  scenario 'host cannot update plans' do
    user = FactoryGirl.create(:host)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit edit_plan_path(plan)
    expect(page).to have_content("You are not authorized")
  end

  scenario 'officer can create plans'  do
    user = FactoryGirl.create(:officer)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit edit_plan_path(plan)
    visit edit_plan_path(plan)
    expect(page).to have_content("You are not authorized")
  end

  # Scenario:
  scenario 'user cannot update plans if not signed in' do
    plan = FactoryGirl.create(:plan)
    visit edit_plan_path(plan)
    expect(page).to have_content("You need to sign in")
  end



end
