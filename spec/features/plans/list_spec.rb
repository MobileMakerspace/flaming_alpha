include Warden::Test::Helpers
Warden.test_mode!

# Feature: list plans
#   As a user
#   I want to login
#   So I can visit the plan list
feature 'List plans', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin can list plans' do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit plans_path()
    expect(page).to have_content("Plans")
  end

  scenario 'host can list plans' do
    user = FactoryGirl.create(:host)
    login_as(user, :scope => :user)
    visit plans_path()
    expect(page).to have_content("Plans")
  end
    scenario 'officer can list plans'do
      user = FactoryGirl.create(:officer)
      login_as(user, :scope => :user)
      visit plans_path()
      expect(page).to have_content("Plans")
    end

  # Scenario:
  scenario 'user cannot list plans if not signed in' do
    visit plans_path()
    expect(page).to have_content("You need to sign in")
  end



end
