class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_question

  def create
    @answer = current_user.answers.build(answer_params)
    @question.answers << @answer
    if @answer.save
      redirect_to @question, notice: 'Your answer was successfully created.'
    else
      redirect_to @question, alert: 'Your answer wasn`t created.'
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:text, :user_id, :question_id)
  end
end
