class Users::RegistrationsController < Devise::RegistrationsController
  def new
    puts "Override!"
    super
  end
end
