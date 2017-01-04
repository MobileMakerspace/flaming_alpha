require "administrate/base_dashboard"

class MembershipDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    contact: Field::BelongsTo,
    plan: Field::BelongsTo,
    id: Field::Number,
    start: Field::DateTime,
    stop: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :contact,
    :plan,
    :id,
    :start,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :contact,
    :plan,
    :id,
    :start,
    :stop,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :contact,
    :plan,
    :start,
    :stop,
  ].freeze

  # Overwrite this method to customize how memberships are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(membership)
  #   "Membership ##{membership.id}"
  # end
end
