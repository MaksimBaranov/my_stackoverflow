class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :value, inclusion: {in: [-1, 1]}

  after_create do |vote|
    voteable_object = vote.voteable
    user = voteable_object.user
    reputation = user.reputation
    if vote.voteable_type == 'Question'
      if vote.value == 1
        user.update(reputation: reputation + ReputationConstant::TWOPOINTS)
      else
        user.update(reputation: reputation - ReputationConstant::TWOPOINTS)
      end
    else
      if vote.value == 1
        user.update(reputation: reputation + ReputationConstant::ONEPOINT)
      else
        user.update(reputation: reputation - ReputationConstant::ONEPOINT)
      end
    end
  end

  def voting(user, vote_object, num)
    @vote ||= Vote.where(user_id: user, voteable_id: vote_object).first
    if @vote.present?
      unless @vote.value == num
        @vote.destroy
      end
    else
      @vote ||= self
      user.votes << @vote
      @vote.voteable = vote_object
      @vote.value = num
      @vote.save
    end
  end

  def vote_sum
    vote.sum(:value)
  end
end
