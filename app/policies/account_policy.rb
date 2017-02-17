class AccountPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @scope = model
  end

  def index?
    @current_user.admin? or @current_user.officer?
  end

  def show?
    @current_user.admin? or @current_user.officer? or @current_user.id.eql?@scope.id
  end


end
