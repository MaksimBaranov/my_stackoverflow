class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_question, only: [:show, :edit, :update]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
  end

  def edit
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:notice] = 'Your question is successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      flash[:notice] = 'Your question has been successfully updated.'
      redirect_to @question
    else
      render :edit
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end
