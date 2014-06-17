class Answer < ActiveRecord::Base
  after_create do |answer|
    user = answer.user
    question = answer.question
    author_question = question.user
    first_answer = question.answers.order('created_at ASC').first
    if first_answer == answer
      if user == author_question
        reputation = author_question.reputation
        author_question.update(reputation: reputation + ReputationConstant::THREEPOINTS)
      else
        reputation = user.reputation
        user.update(reputation: reputation + ReputationConstant::TWOPOINTS)
      end
    else
      if user == author_question
        reputation = author_question.reputation
        author_question.update(reputation: reputation + ReputationConstant::TWOPOINTS)
      else
        reputation = user.reputation
        user.update(reputation: reputation + ReputationConstant::ONEPOINT)
      end
    end
  end

  after_update do |answer|
    user = answer.user
    if answer.best == true
      reputation = user.reputation
      user.update(reputation: reputation + ReputationConstant::THREEPOINTS)
    end
  end
  belongs_to :user
  belongs_to :question, :counter_cache => true
  has_many :vote, as: :voteable
  has_many :favorites, as: :favoriteable
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable

  validates :text, presence: true
  validates :text, length: { in: 10..600 }

  accepts_nested_attributes_for :attachments
end
