require 'support/helpers/session_helpers'
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end

def select_date(date, options = {})
  field = options[:from]
  select date.strftime('%Y'), :from => "#{field}_1i" #year
  select date.strftime('%B'), :from => "#{field}_2i" #month
  select date.strftime('%d'), :from => "#{field}_3i" #day
end
