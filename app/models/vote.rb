class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  has_many :preferences
  has_many :users, through: :preferences

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

  def vote_up(user, num)
      self.update_attributes(quantity: self.quantity + num)
      self.users << user
  end

  def vote_down(user, num)
    self.update_attributes(quantity: self.quantity + num)
    self.users << user
  end
end
