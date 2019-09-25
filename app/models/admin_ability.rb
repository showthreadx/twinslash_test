class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user && user.admin?
      can :access, :rails_admin
      can :read, :dashboard
      can :read, :all
      can :destroy, Ad
      can :update, Ad
      can :create, User
      can :destroy, User
      can :update, User
      can :create, AdType
      can :destroy, AdType
      can :approve, Ad
    end
  end
end
