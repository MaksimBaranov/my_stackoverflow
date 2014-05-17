class Answer < ActiveRecord::Base
  after_create :create_new_vote
  belongs_to :user
  belongs_to :question
  belongs_to :vote
  has_many :comments, as: :commentable
  validates :text, presence: true
  validates :text, length: { in: 10..600 }

  def create_new_vote
    Answer.last.create_vote
  end
end
