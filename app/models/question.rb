class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  validates :title, :body, presence: true
  validates :title, length: { in: 10..100 }
  validates :body, length: { in: 50..600 }
end
