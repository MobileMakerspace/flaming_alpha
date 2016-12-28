class MemberPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @members = model
  end

  def index?
    @current_user.admin? or @current_user.host? or @current_user.officer?
  end

  def show?
    @current_user.admin? or @current_user.host? or @current_user.officer?
  end


  def destroy?
    return false
  end
end
