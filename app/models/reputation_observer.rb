class ReputationObserver < ActiveRecord::Observer
  observe :vote, :answer

  def after_create(record)
    if record.class.name == 'Vote'
      change_reputation_via_votes(record)
    else
      change_reputation_via_answers(record)
    end
  end

  def after_update(record)
    change_reputation_via_best_answer(record) if record.class.name == 'Answer'
  end

  def after_destroy(record)
    cancel_votes(record) if record.class.name == 'Vote'
  end

  private

  def cancel_votes(vote)
    voteable_object = vote.voteable
    user = voteable_object.user
    reputation = user.reputation
    if vote.voteable_type == 'Question'
      if vote.value == 1
        user.update(reputation: reputation - ReputationConstant::POINT[:two])
      else
        user.update(reputation: reputation + ReputationConstant::POINT[:two])
      end
    else
      if vote.value == 1
        user.update(reputation: reputation - ReputationConstant::POINT[:one])
      else
        user.update(reputation: reputation + ReputationConstant::POINT[:one])
      end
    end
  end

# constant = vote.votable_type.is_a?(Question) ? :two : :one
# TODO: refactoring if-statments
#            on the all callbacks via
#            method change_reputation
# def change_reputation(vote_value, points, reputation)
#     variables =
#       vote_value == 1 ? {sign: :+, points: points} : {sign: :-, points: points}
#     reputation.send variables[:sign], variables[:points]
# end

  def change_reputation_via_best_answer(answer)
    user = answer.user
    if answer.best == true
      reputation = user.reputation
      user.update(reputation: reputation + ReputationConstant::POINT[:three])
    end
  end

  def change_reputation_via_votes(vote)
    voteable_object = vote.voteable
    user = voteable_object.user
    reputation = user.reputation
    if vote.voteable_type == 'Question'
      if vote.value == 1
        user.update(reputation: reputation + ReputationConstant::POINT[:two])
      else
        user.update(reputation: reputation - ReputationConstant::POINT[:two])
      end
    else
      if vote.value == 1
        user.update(reputation: reputation + ReputationConstant::POINT[:one])
      else
        user.update(reputation: reputation - ReputationConstant::POINT[:one])
      end
    end
  end

  def change_reputation_via_answers(answer)
    user = answer.user
    question = answer.question
    author_question = question.user
    first_answer = question.answers.order('created_at ASC').first
    if first_answer == answer
      if user == author_question
        reputation = author_question.reputation
        author_question.update(reputation: reputation +
                                           ReputationConstant::POINT[:three])
      else
        reputation = user.reputation
        user.update(reputation: reputation + ReputationConstant::POINT[:two])
      end
    else
      if user == author_question
        reputation = author_question.reputation
        author_question.update(reputation: reputation +
                                              ReputationConstant::POINT[:two])
      else
        reputation = user.reputation
        user.update(reputation: reputation + ReputationConstant::POINT[:one])
      end
    end
  end
end
