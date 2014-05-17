class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :vote
  has_many :comments, as: :commentable
  validates :text, presence: true
  validates :text, length: { in: 10..600 }
end
