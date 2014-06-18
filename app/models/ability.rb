class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.admin ? admin_abilities : user_abilities(user)
    else
      quest_abilities
    end
  end

  def quest_abilities
    can :read, [Question, Answer, Comment, Tag, User]
  end

  def user_abilities(user)
    can :read, :all
    can :create, [Question, Answer, Comment, Tag]
    can :update, [Question, Answer, Comment], user_id: user.id
    can :destroy, [Question, Answer, Comment], user_id: user.id
    can :best, Answer
    cannot :best, Answer, user_id: user.id
    can :up, Vote
    can :down, Vote
    cannot :up, Vote, user_id: user.id
    cannot :down, Vote, user_id: user.id
    can :favor, Favorite
  end

  def admin_abilities
    can :manage, :all
  end
end
