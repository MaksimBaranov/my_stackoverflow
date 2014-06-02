class Question < ActiveRecord::Base

  attr_accessor :tag_names

  before_save :save_tags

  after_create :create_new_vote
  belongs_to :user
  has_one :vote, as: :voteable
  has_many :answers
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :body, presence: true
  validates :title, length: { in: 10..100 }
  validates :body, length: { in: 50..600 }

  accepts_nested_attributes_for :attachments

  def self.with_tag(name)
    Tag.find_by_name!(name).questions
  end

  def tags_list
    self.tags.map(&:name)
  end

  def save_tags
    self.tags = @tag_names.split(',').map { |n| Tag.where(name: n.strip).first_or_create! }
  end

  def create_new_vote
    self.create_vote
  end
end
