class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :text
  validates_length_of :text, in: 20..600

  def question
    if self.commentable.class == Question
      self.commentable
    else self.commentable.class == Answer
      self.commentable.question
    end
  end
end
