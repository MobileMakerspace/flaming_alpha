include Warden::Test::Helpers
Warden.test_mode!

feature 'List account(s)', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can list accounts' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit accounts_path()
    expect(page).to have_content("Ledger")
  end

  scenario 'user can not list accounts' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit accounts_path()
    expect(page).to have_content("not authorized")
  end

  # Scenario:
  scenario 'user cannot list plans if not signed in' do
    visit accounts_path()
    expect(page).to have_content("You need to sign in")
  end

  scenario 'admin can view a user ledger' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    visit account_path(member.id)
    expect(page).to have_content("Ledger")
  end

  scenario 'user can view their ledger' do
    user = FactoryGirl.create(:admin)
    member = FactoryGirl.create(:user)
    login_as(member, :scope => :user)

    visit account_path(member.id)
    expect(page).to have_content("Ledger")
  end

end
