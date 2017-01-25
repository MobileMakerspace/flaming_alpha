class SubscriptionPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @subscription = model
  end

  def index?
    @current_user.admin?
  end

  def new?
    !@current_user.nil?
  end

  def create?
    !@current_user.nil?
  end

  def destroy?
    return false
  end

end
