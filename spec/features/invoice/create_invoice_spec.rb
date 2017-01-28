include Warden::Test::Helpers
Warden.test_mode!

feature 'Create invoices', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create a invoice' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit invoice_path(member.id)
    expect(page).to have_content("Ledger")
    fill_in 'Amount', :with => '9999'
    fill_in 'Note', :with => 'manual bill'
    #fill_in 'Start', :with => '2016-11-01'
    select_date(Date.today.at_beginning_of_month, from: 'invoice_start')
    select_date(Date.today.at_end_of_month, from: 'invoice_stop')
    click_button 'Create Invoice'
    expect(page).to have_content("Invoice was successfully created")
  end

  scenario 'user can not create invoices' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(member, :scope => :user)
    visit invoice_path(member.id)
    expect(page).to have_content("You are not authorized")
  end

  # Scenario:
  scenario 'user cannot list plans if not signed in' do
    user = FactoryGirl.create(:admin)
    visit invoice_path(user.id)
    expect(page).to have_content("You need to sign in")
  end


end
