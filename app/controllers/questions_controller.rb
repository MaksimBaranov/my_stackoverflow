class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_question, only: [:show, :edit, :update, :destroy]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @question.attachments.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @answers = @question.answers
    @comments = @question.comments
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Your question is successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Your question has been successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
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
    params.require(:question).permit(:title, :body, :user_id, attachments_attributes: [:file])
  end
end
