include Warden::Test::Helpers
Warden.test_mode!

# Feature: Create an invoice for a member
#   As a user
#   I want to login
#   So I can invoice a member
feature 'Create invoice', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create an invoice for a member' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:member)
    login_as(user, :scope => :user)
    visit contact_memberships_path(contact_id: member.id) #contact_id: member.id
    expect(page).to have_content(member.contact.name)
    click_link 'Create Invoice'
    expect(page).to have_content(member.contact.name)
    fill_in 'Description', :with => 'Full Membership', match: :first
    fill_in 'Unit price', :with => '50.00', match: :first
    click_button 'Create Invoice'
    expect(page).to have_content("Invoice was successfully created")
  end


end
