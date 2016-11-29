class ContactMembershipFormPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @contact_membership_form = model
  end

  def new?
    @current_user.admin? or @current_user.host? or @current_user.officer?
  end

  def create?
    @current_user.admin? or @current_user.host? or @current_user.officer?
  end


end
