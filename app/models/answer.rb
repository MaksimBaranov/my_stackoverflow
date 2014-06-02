class Answer < ActiveRecord::Base
  after_create :create_new_vote
  belongs_to :user
  belongs_to :question
  has_one :vote, as: :voteable
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable

  validates :text, presence: true
  validates :text, length: { in: 10..600 }

  accepts_nested_attributes_for :attachments


  def create_new_vote
    self.create_vote
  end
end
