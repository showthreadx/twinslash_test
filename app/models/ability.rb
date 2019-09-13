# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user.present? && !user.admin?
      can :create, Ad
      can :destroy, Ad, user_id: user.id, status: 0
      can :destroy, Ad, user_id: user.id, status: 2
      can :update, Ad, user_id: user.id, status: 0
      can :update, Ad, user_id: user.id, status: 2
      can :pending, Ad, user_id: user.id
    end

    if user && user.admin?
      can :access, :rails_admin
      can :read, :dashboard
      can :destroy, Ad
      can :destroy, User
      can :update, Ad
      can :update, User
      can :create, User
    end
  end
end
