class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, only: :create

  protected

  def configure_permitted_parameters
    pp params
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
  end
end
