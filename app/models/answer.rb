class Answer < ActiveRecord::Base
  after_create :change_reputation_via_addition_answer
  after_update :change_reputation_via_best_answer

  belongs_to :user
  belongs_to :question, :counter_cache => true
  has_many :votes, as: :voteable
  has_many :favorites, as: :favoriteable
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable

  validates :text, presence: true
  validates :text, length: { in: 10..600 }

  accepts_nested_attributes_for :attachments

  def change_reputation_via_addition_answer
    user = self.user
    question = self.question
    author_question = question.user
    first_answer = question.answers.order('created_at ASC').first
    if first_answer == self
      if user == author_question
        reputation = author_question.reputation
        author_question.update(reputation: reputation + 3)
      else
        reputation = user.reputation
        user.update(reputation: reputation + 2)
      end
    else
      if user == author_question
        reputation = author_question.reputation
        author_question.update(reputation: reputation + 2)
      else
        reputation = user.reputation
        user.update(reputation: reputation + 1)
      end
    end
  end

  def change_reputation_via_best_answer
    user = self.user
    if self.best == true
      reputation = user.reputation
      user.update(reputation: reputation + 3)
    end
  end
end
