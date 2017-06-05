class Ability
  include CanCan::Ability

  # you don't need to explicitly instantiate an instance of this 'ability' class
  # it will be done automatically.  The main thing to keep in mind is that you must have a method
  # called 'current_user' available in your application controller that will return
  # the currently signed in user.

  def initialize(user)

    # we define all the rules and permissions to our app in this method
    # for full details visit the gitHub page for cancancan

    #  if user is not signed in, current_user will return 'nil' so we set it to 'User.new'
    # if the user is not signed in to ease writing rules by simply doing 'user.id' which will return 'nil'
    # instead of raising an exception
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud

    # this rule specifies that the user can 'crud' a question if the question creator
    # (question.user) is the same as 'user' who is the current logged in user.
    # remember that this defines a rule but you still have to endforce the rule yourself
    # by implementing it in your views controllers.
    can :crud, Question do |question|
      question.user == user
    end

    # ':manage' option in cancancan gives the user the abilty to do anything and not just crud
    # for example, if you have other actions such as publish, activate, disable ...etc.
    #  :manage
    if user.is_admin?
      can :manage, :all
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
