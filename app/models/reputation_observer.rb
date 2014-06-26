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
    if record.class.name == 'Answer'
      change_reputation_via_best_answer(record)
    end
  end

  def after_destroy(record)
    if record.class.name == 'Vote'
      cancel_votes(record)
    end
  end

  private

  def cancel_votes(vote)
    voteable_object = vote.voteable
    user = voteable_object.user
    reputation = user.reputation
    if vote.voteable_type == 'Question'
      if vote.value == 1
        user.update(reputation: reputation - 2)
      else
        user.update(reputation: reputation + 2)
      end
    else
      if vote.value == 1
        user.update(reputation: reputation - 1)
      else
        user.update(reputation: reputation + 1)
      end
    end
  end

  def change_reputation_via_best_answer(answer)
    user = answer.user
    if answer.best == true
      reputation = user.reputation
      user.update(reputation: reputation + 3)
    end
  end

  def change_reputation_via_votes(vote)
    voteable_object = vote.voteable
    user = voteable_object.user
    reputation = user.reputation
    if vote.voteable_type == 'Question'
      if vote.value == 1
        user.update(reputation: reputation + 2)
      else
        user.update(reputation: reputation - 2)
      end
    else
      if vote.value == 1
        user.update(reputation: reputation + 1)
      else
        user.update(reputation: reputation - 1)
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

end
