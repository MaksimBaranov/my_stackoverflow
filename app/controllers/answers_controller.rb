class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_question

  def create
    @answer = current_user.answers.build(answer_params)
    @question.answers << @answer
    if @answer.save
      redirect_to @question, notice: 'Your answer has been successfully created.'
    else
      redirect_to @question, alert: 'Your answer hasn`t been created. Try again.'
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to @question, notice: 'Answer has been successfully updated.'
    else
      flash[:alert] = 'Answer hasn`t been updated. Try again.'
      render :edit
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
