class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    end
    can :crud, Post do |post|
      post.user == user
    end
    can :crud, Comment do |comment|
      comment.user == user
    end
  
  end
end
