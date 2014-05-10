class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_question

  def create
    @answer = current_user.answers.build(answer_params)
    @question.answers << @answer
    @answer.save
       flash[:notice] = 'Your answer is successfully created.'
       redirect_to @question
    # else
    #   render
    # end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:text, :user_id, :question_id)
  end
end
