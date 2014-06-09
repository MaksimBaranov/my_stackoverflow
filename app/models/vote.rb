class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :value, inclusion: {in: [-1, 1]}

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
    votes.sum(:value)
  end
end
