class Question < ActiveRecord::Base
  validates :title, :body, presence: true
  validates :title, length: { maximum: 50 }
  validates :body, length: { maximum: 150 }
end
