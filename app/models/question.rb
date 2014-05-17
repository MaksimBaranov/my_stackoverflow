class Question < ActiveRecord::Base
  after_create :create_new_vote
  belongs_to :user
  belongs_to :vote
  has_many :answers
  has_many :comments, as: :commentable
  validates :title, :body, presence: true
  validates :title, length: { in: 10..100 }
  validates :body, length: { in: 50..600 }

  def create_new_vote
    Question.last.create_vote
  end
end
