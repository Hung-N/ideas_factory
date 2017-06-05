class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

      # alias_action :create, :read, :update, :destroy, to: :crud

      # if user.is_admin?
      #   can :manage, :all
      # end

      # can [:edit, :update, :destroy], Idea do |idea|
      can :destroy, Idea do |idea|
        idea.user == user
      end

      # can :destroy, Review do |review|
      #   review.user == user
      # end
      #
      # can :create, Review do |review|
      #   user != review.product.user
      # end

  end
end
