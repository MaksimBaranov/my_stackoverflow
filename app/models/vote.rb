class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  has_many :preferences
  belongs_to :user

  validates :quantity, numericality: { only_integer: true }

  VOTE = {
        like: 1,
    dislike: -1
  }

  def question
    if self.voteable.class == Question
      self.voteable
    else self.voteable.class == Answer
      self.voteable.question
    end
  end

  def voting(user, num)
    if user.preferences.where(vote_id: self).empty?
      self.users << user
      self.update_attributes(quantity: self.quantity + num)
    else
      false
    end
  end
end
