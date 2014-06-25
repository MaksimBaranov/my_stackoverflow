class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :value, inclusion: {in: [-1, 1]}

  after_create :change_reputation

  def change_reputation
    voteable_object = self.voteable
    user = voteable_object.user
    reputation = user.reputation
    if self.voteable_type == 'Question'
      if self.value == 1
        user.update(reputation: reputation + 2)
      else
        user.update(reputation: reputation - 2)
      end
    else
      if self.value == 1
        user.update(reputation: reputation + 1)
      else
        user.update(reputation: reputation - 1)
      end
    end
  end

  def voting(user, vote_object, num)
    @vote ||= Vote.where(user_id: user, voteable_id: vote_object).first
    if @vote.present?
      @vote.destroy unless @vote.value == num
    else
      @vote ||= self
      @vote.voteable = vote_object
      @vote.value = num
      user.votes << @vote
      @vote.save!
    end
  end

  def vote_sum
    vote.sum(:value)
  end
end
