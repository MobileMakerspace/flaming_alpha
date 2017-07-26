include Warden::Test::Helpers
Warden.test_mode!

feature 'Create refunds', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can refund overpayment' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit refund_path(member.id)
    expect(page).to have_content("Ledger")
    fill_in 'Amount', :with => '99.99'
    fill_in 'Note', :with => 'refund overpayment'
    click_button 'Create Refund'
    expect(page).to have_content("Refund was successfully created")
    expect(page).to have_content("-99.99")
  end

  scenario 'user can not refund' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(member, :scope => :user)
    visit refund_path(member.id)
    expect(page).to have_content("You are not authorized")
  end

  # Scenario:
  scenario 'user cannot refund if not signed in' do
    user = FactoryGirl.create(:admin)
    visit refund_path(user.id)
    expect(page).to have_content("You need to sign in")
  end


end
