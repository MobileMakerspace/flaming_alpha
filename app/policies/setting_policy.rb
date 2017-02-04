class SettingPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @scope = model
  end

  def index?
    @current_user.admin?
  end

  def edit?
    @current_user.admin?
  end

  def update?
    @current_user.admin?
  end
end
