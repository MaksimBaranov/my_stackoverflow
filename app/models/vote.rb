class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  validates :quantity, numericality: { only_integer: true }
  # TODO list
  # 4. Rewrite tests of editing comments to js
  # 7. Rerite tests of deleteion comments to js
  # 8. Tags
  # 10. Add Bootstrap and make goodlooking perfomance of app
  # 16. Write tests on models

  def question
    if self.voteable.class == Question
      self.voteable
    else self.voteable.class == Answer
      self.voteable.question
    end
  end

  def add_vote
    self.quantity + 1
  end

  def down_vote
    self.quantity - 1
  end
end
