json.extract! contact, :id, :name, :email, :phone, :emergency_name, :emergency_phone, :addr_1, :addr_2, :city, :state, :zip, :created_at, :updated_at
json.url contact_url(contact, format: :json)