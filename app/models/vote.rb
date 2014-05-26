class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  validates :quantity, numericality: { only_integer: true }
  # TODO list
  # 2. Rewrite tests of editing answer to JS(fix bug with errors and complete check access of alias answer)
  # 3. Rerite tests of editing questions to js
  # 4. Rewrite tests of editing comments to js
  # 5. Rerite tests of deleteion questions to js
  # 6. Rerite tests of deleteion answer to js
  # 7. Rerite tests of deleteion comments to js
  # 12. Add ajax to voting.
  # 9. Add attaching files to answers and questions
  # 10. Add Bootstrap and make goodlooking perfomance of app
  # 11. Look screencast of json and make exercise
  # Sunday evening - Saturday morgning and evening
  # 13. User can edit his profile(ajax)
  # 14. User can look at profiles other users.
  # 15. User can download his avatar.(ajax)
  # Monday

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
