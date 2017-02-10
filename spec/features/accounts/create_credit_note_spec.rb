include Warden::Test::Helpers
Warden.test_mode!

feature 'Create credit notes', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can create a credit note' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit credit_note_path(member.id)
    expect(page).to have_content("Ledger")
    fill_in 'Amount', :with => '99.99'
    fill_in 'Note', :with => 'credit user for over billed'
    click_button 'Create Credit Note'
    expect(page).to have_content("Credit note was successfully created")
    expect(page).to have_content("99.99")
  end

  scenario 'user can not create credit notes' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(member, :scope => :user)
    visit credit_note_path(member.id)
    expect(page).to have_content("You are not authorized")
  end

  # Scenario:
  scenario 'user cannot list plans if not signed in' do
    user = FactoryGirl.create(:admin)
    visit credit_note_path(user.id)
    expect(page).to have_content("You need to sign in")
  end


end
