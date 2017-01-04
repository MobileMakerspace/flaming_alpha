require "administrate/base_dashboard"

class ContactDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    memberships: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    phone: Field::String,
    emergency_name: Field::String,
    emergency_phone: Field::String,
    addr_1: Field::String,
    addr_2: Field::String,
    city: Field::String,
    state: Field::String,
    zip: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :memberships,
    :id,
    :name,
    :email,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :memberships,
    :id,
    :name,
    :email,
    :phone,
    :emergency_name,
    :emergency_phone,
    :addr_1,
    :addr_2,
    :city,
    :state,
    :zip,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :memberships,
    :name,
    :email,
    :phone,
    :emergency_name,
    :emergency_phone,
    :addr_1,
    :addr_2,
    :city,
    :state,
    :zip,
  ].freeze

  # Overwrite this method to customize how contacts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(contact)
  #   "Contact ##{contact.id}"
  # end
end
