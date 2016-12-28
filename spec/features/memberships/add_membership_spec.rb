include Warden::Test::Helpers
Warden.test_mode!

# Feature: add membership
#   As a user
#   I want to login
#   So I can add a membership to a contact
feature 'Add membership', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can add a membership to a contact' do
    user = FactoryGirl.create(:admin)
    contact = FactoryGirl.create(:contact)
    plan = FactoryGirl.create(:plan)
    login_as(user, :scope => :user)
    visit contact_path(contact)
    expect(page).to have_content("MyString")
    # enter membership information
    click_link 'New Membership'
    select "#{plan.name}", :from => "membership_plan_id"
    select_date(Date.today, from: 'membership_start')
    click_button 'Add Membership'
    expect(page).to have_content("Membership was successfully created")
    # submit
    # expect a new entry in the membership list??
  end


end
