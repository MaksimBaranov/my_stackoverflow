class Question < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  attr_accessor :tag_names

  before_save :save_tags

  belongs_to :user
  has_many :votes, as: :voteable
  has_many :favorites, as: :favoriteable
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :body, presence: true
  validates :title, length: { in: 10..100 }
  validates :body, length: { in: 50..600 }

  is_impressionable counter_cache: true, column_name: :views_count, unique: :true

  accepts_nested_attributes_for :attachments

  scope :newest, -> { order(created_at: :desc) }
  scope :popular, -> { order(views_count: :desc) }
  scope :voted, -> { joins(:vote).where('value > 0') }
  scope :unanswered, -> { where(answers_count: 0) }

  def self.with_tag(name)
    Tag.find_by_name!(name).questions
  end

  def tags_list
    self.tags.map(&:name)
  end

  def save_tags
    self.tags = @tag_names.split(',').map { |n| Tag.where(name: n.strip).first_or_create! }
  end

  def votes_count
    self.votes.sum(:value)
  end

  def  self.eager_loading
    includes(:tags)
  end
end
