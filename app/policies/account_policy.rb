class AccountPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @scope = model
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? or @current_user.id == @scope
  end


end
