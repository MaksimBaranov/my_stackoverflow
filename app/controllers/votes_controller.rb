class VotesController < ApplicationController
  before_filter :authenticate_user!

  def up_vote
    @vote = Vote.find(params[:id])
    current_quantity_vote = @vote.quantity
    if @vote.update_attributes(quantity: current_quantity_vote + 1)
      redirect_to  current_question(@vote), notice: 'Your voice has been added.'
    else
      redirect_to  current_question(@vote), alert: 'Try Again.'
    end
  end

  def down_vote
    @vote = Vote.find(params[:id])
    current_quantity_vote = @vote.quantity
    if @vote.update_attributes(quantity: current_quantity_vote - 1)
      redirect_to  current_question(@vote), notice: 'You have subtracted voice.'
    else
      redirect_to  current_question(@vote), alert: 'Try Again.'
    end
  end

  private

  def current_question(vote)
    if vote.question
      question_path(vote.question.id)
    else
      answer = vote.answer
      question_path(answer.question.id)
    end
  end

end
