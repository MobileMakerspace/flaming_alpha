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
    select_date(Date.today, from: 'contact_membership_form_start')

    click_button 'Create Membership'
    expect(page).to have_content("Membership was successfully created")
  end

  scenario 'host can create memberships' do
    user = FactoryGirl.create(:host)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit new_membership_path()
    fill_in 'Name', :with => 'New User'
    fill_in 'Email', :with => 'jane@exmple.com'
    fill_in 'Emergency name', :with => 'Jane Doe'
    fill_in 'Emergency phone', :with => '555-1212'
    fill_in 'Phone', :with => '123-4567'

    select "#{plan.name}", :from => "membership_plan_id"
    select_date(Date.today, from: 'contact_membership_form_start')
    click_button 'Create Membership'
    expect(page).to have_content("Membership was successfully created")
  end

  scenario 'officer can create memberships'  do
    user = FactoryGirl.create(:officer)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit new_membership_path()
    fill_in 'Name', :with => 'New User'
    fill_in 'Email', :with => 'jane@exmple.com'
    fill_in 'Emergency name', :with => 'Jane Doe'
    fill_in 'Emergency phone', :with => '555-1212'
    fill_in 'Phone', :with => '123-4567'

    select "#{plan.name}", :from => "membership_plan_id"
    select_date(Date.today, from: 'contact_membership_form_start')
    click_button 'Create Membership'
    expect(page).to have_content("Membership was successfully created")
  end

  scenario 'user cannot create memberships'  do
    user = FactoryGirl.create(:user)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit new_membership_path()
    expect(page).to have_content("You are not authorized to perform this action.")
  end

  # Scenario:
  scenario 'user cannot add memberships if not signed in' do
    visit new_membership_path()
    expect(page).to have_content("You need to sign in")
  end

end
