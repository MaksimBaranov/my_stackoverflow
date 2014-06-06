class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  has_many :preferences
  has_many :users, through: :preferences

  #attr_accessor :user_voted

  validates :quantity, numericality: { only_integer: true }
  #validate :user_has_voted_already, on: :update

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

  def user_has_voted_already
    if self.users.where(user_id: self.user_voted)
      errors[:base] << "You can not vote second time"
    end
  end
end
