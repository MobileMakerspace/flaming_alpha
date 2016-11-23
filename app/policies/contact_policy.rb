class ContactPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @contact = model
  end

  def new?
    @current_user
  end

  def create?
    @current_user
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? or @current_user == @contact.user
  end

  def edit?
    @current_user == @contact.user
  end

  def update?
    @current_user == @contact.user
  end

  def destroy?
    return false
  end

end
