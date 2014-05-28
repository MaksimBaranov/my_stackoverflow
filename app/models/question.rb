class Question < ActiveRecord::Base
  after_create :create_new_vote
  belongs_to :user
  has_one :vote, as: :voteable
  has_many :answers
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable
  validates :title, :body, presence: true
  validates :title, length: { in: 10..100 }
  validates :body, length: { in: 50..600 }

  accepts_nested_attributes_for :attachments

  def create_new_vote
    self.create_vote
  end
end
