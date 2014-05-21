class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_question, only: [:show, :edit, :update, :destroy]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @answers = @question.answers
    @comments = @question.comments
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
      redirect_to @question, notice: 'Your question has been successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Your question has been removed.'
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end
