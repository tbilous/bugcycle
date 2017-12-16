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

    can :apply, [Suggestion] do |object|
      object.author_id == @user.id
    end

    can :destroy, [Suggestion] do |object|
      object.user_id == @user.id || object.author_id == @user.id
    end

    can :create, [Category, Item, BlackList, Suggestion]

    can :update, [Suggestion], user_id: @user.id

    can :modify, [BlackList], user_id: @user.id

    can :modify, [Item], user_id: @user.id

    can :me, User
  end
end
