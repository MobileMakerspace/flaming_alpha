json.extract! addon, :id, :name, :price, :active, :authrequired, :created_at, :updated_at
json.url addon_url(addon, format: :json)