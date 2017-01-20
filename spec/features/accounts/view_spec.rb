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
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit accounts_path()
    expect(page).to have_content("not authorized")
  end

  # Scenario:
  scenario 'user cannot list plans if not signed in' do
    visit accounts_path()
    expect(page).to have_content("You need to sign in")
  end



end
