class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user.present? && !user.admin?
      can [:create, :user_ads, :user_archive, :delete_image], Ad
      can :destroy, Ad, user_id: user.id
      can :update, Ad, user_id: user.id, status: [0, 2]
      can :status_new, Ad, user_id: user.id, status: [0, 2]
      can :status_draft, Ad, user_id: user.id, status: 5
    end
  end
end
