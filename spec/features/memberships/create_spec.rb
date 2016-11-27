include Warden::Test::Helpers
Warden.test_mode!

# Feature: create memberships
#   As a user
#   I want to login
#   So I can create a membership
feature 'Create Membership', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create a membership' do
    user = FactoryGirl.create(:admin)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit new_membership_path()
    fill_in 'Name', :with => 'New User'
    fill_in 'Email', :with => 'jane@exmple.com'
    fill_in 'Emergency name', :with => 'Jane Doe'
    fill_in 'Emergency phone', :with => '555-1212'
    fill_in 'Phone', :with => '123-4567'

    select "#{plan.name}", :from => "membership_plan_id"
    fill_in 'Start', :with => '2016/10/01'
    click_button 'Create Membership'
    expect(page).to have_content("Membership was successfully created")
  end

  scenario 'host can create memberships'

  scenario 'officer can create memberships'

  scenario 'user cannot create memberships'

  # Scenario:
  scenario 'user cannot add memberships if not signed in'

end
