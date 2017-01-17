class SeedDevelopmentService
  def call(params=nil)
    user = User.find_or_create_by!(email: 'member@example.org') do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.confirm
      end
    plan = Plan.new(name: "Full", price: 50)
    plan.save
    subscription = Subscription.new(plan_id: plan.id, user_id: user.id, start: Time.now)
    subscription.save
  end
end
