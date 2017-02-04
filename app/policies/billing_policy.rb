class BillingPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @scope = model
  end

  def new?
    @current_user.admin?
  end

  def create?
    @current_user.admin?
  end


end
