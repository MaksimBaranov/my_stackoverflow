class Vote < ActiveRecord::Base
  has_one :question
  has_one :answer
  validates :quantity, numericality: { only_integer: true }
  #rewrite
  # TODO list
  # 1. Change associattion of Vote to polymorphic
  # 2. Rewrite tests of editing answer to JS
  # 3. Rerite tests of editing questions to js
  # 4. Rewrite tests of editing comments to js
  # 5. Rerite tests of deleteion questions to js
  # 6. Rerite tests of deleteion answer to js
  # 7. Rerite tests of deleteion comments to js
  # 9. Add attaching files to answers and questions
  # 10. Add Bootstrap and make goodlooking perfomance of app
  # 11. Look screencast of json and make exercise
  # 12. Add ajax to voting.
  # Sunday evening - Saturday morgning and evening
  # 13. User can edit his profile(ajax)
  # 14. User can look at profiles other users.
  # 15. User can download his avatar.(ajax)
  # Monday
end
