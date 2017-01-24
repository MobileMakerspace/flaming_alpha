class Users::RegistrationsController < Devise::RegistrationsController
  def new
    if Rails.env.production?
      flash[:info] = 'Registrations are not open yet, but please check back soon'
      redirect_to root_path
    else
      super
    end
  end
  def create
    if Rails.env.production?
      flash[:info] = 'Registrations are not open yet, but please check back soon'
      redirect_to root_path
    else
      super
    end
  end
end
