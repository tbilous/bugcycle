class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    alias_action :update, :destroy, to: :modify

    user ? user_abilities : guest_abilities
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities

    can :create, [Category, Item]

    can :modify, [Category]

    can :modify, [Item], user_id: @user.id

    can :me, User
  end
end
