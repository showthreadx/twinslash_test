class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user.present? && !user.admin?
      can :create, Ad
      can :user_ads, Ad
      can :user_archive, Ad
      can :update, Ad, user_id: user.id, status: 0
      can :destroy, Ad, user_id: user.id, status: 0
      can :destroy, Ad, user_id: user.id, status: 1
      can :destroy, Ad, user_id: user.id, status: 3
      can :update, Ad, user_id: user.id, status: 2
      can :destroy, Ad, user_id: user.id, status: 2
      can :update, Ad, user_id: user.id, status: 5
      can :destroy, Ad, user_id: user.id, status: 5
      can :status_new, Ad, user_id: user.id, status: 0
      can :status_new, Ad, user_id: user.id, status: 2
      can :status_new, Ad, user_id: user.id, status: 5
    end

    if user && user.admin?
      can :access, :rails_admin
      can :read, :dashboard
      can :destroy, Ad
      can :edit, Ad
      can :update, Ad, :status
      can :update, Ad, :category
      can :create, User
      can :destroy, User
      can :update, User
    end
  end
end
