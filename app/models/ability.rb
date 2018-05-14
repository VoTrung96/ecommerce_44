class Ability
  include CanCan::Ability

  def initialize user
    user.admin? ? permission_admin(user) : permission_subcriber(user)
  end

  private

  def permission_admin user
    can :manage, :all
    cannot :destroy, Order, status: %i(Order.accept Order.pending)
    cannot :update, Order, status: %i(Order.accept Order.pending)
    cannot :destroy, User, id: user.id
  end

  def permission_subcriber user
    can :read, :all
    can :update, User, id: user.id
    can :update, Order, status: Order.pending, user_id: user.id
  end
end
