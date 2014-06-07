module VotesHelper
  def up_vote_link(object)
    if current_user.votes.where(voteable_id: object, value: 1).empty?
      if object.class == Question
          link_to 'Up Vote', question_up_vote_path(object), method: :post,  :remote => true
      else
          link_to 'Up Vote', answer_up_vote_path(object), method: :post,  :remote => true
      end
    else
      'Up Vote'
    end
  end


  def down_vote_link(object)
    if current_user.votes.where(voteable_id: object, value: -1).empty?
      if object.class == Question
          link_to 'Down Vote', question_down_vote_path(object), method: :post,  :remote => true
      else
          link_to 'Down Vote', answer_down_vote_path(object), method: :post,  :remote => true
      end
    else
      'Down Vote'
    end
  end
end
