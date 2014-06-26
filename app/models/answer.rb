class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, :counter_cache => true
  has_many :votes, as: :voteable
  has_many :favorites, as: :favoriteable
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable

  validates :text, presence: true
  validates :text, length: { in: 10..600 }

  accepts_nested_attributes_for :attachments
end
