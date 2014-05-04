class Question < ActiveRecord::Base
  belongs_to :user
  validates :title, :body, presence: true
  validates :title, length: { maximum: 50 }
  validates :body, length: { maximum: 300 }
end
