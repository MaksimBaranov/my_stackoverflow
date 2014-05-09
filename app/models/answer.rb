class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  validates :text, presence: true
  validates :text, length: { in: 50..600 }
end
