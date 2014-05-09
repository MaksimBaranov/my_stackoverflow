class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_question_id

  def create

  end

  private

  def load_question_id
    @question = Question.find(params[:question_id])
  end
end
