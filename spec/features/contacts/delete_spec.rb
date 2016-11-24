include Warden::Test::Helpers
Warden.test_mode!

# Feature: delete contacts
#   As a user
#   I want to login
#   So I can delete a contact
feature 'Delete', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario:
  scenario 'admin cannot delete contacts'

  scenario 'host cannot delete contacts'

  scenario 'officer cannot delete contacts'

  # Scenario:
  scenario 'user cannot delete contacts if not signed in'


end
