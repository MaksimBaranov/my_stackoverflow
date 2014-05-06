class QuestionsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :delete]
  before_filter :load_question, only: [:show]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
