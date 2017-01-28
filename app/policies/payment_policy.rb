class PaymentPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @scope = model
  end

  def update?
    @current_user.admin?
  end

  def show?
    @current_user.admin?
  end


end
