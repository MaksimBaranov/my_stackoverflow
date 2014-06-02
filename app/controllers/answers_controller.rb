class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_question
  before_filter :set_answer, :check_authority,  only: [:edit, :update]

  def create
    @answer = @question.answers.build(answer_params)
    current_user.answers << @answer
    respond_to do |format|
      if  @answer.save
        format.html {  redirect_to @question, notice: 'Your answer has been successfully created.' }
        format.js
        format.json { render json: @answer.to_json(:include => [:vote, :comments, :attachments]) }
      else
        format.html do
          flash[:alert] = 'Your answer hasn`t been created. Try again.'
          redirect_to @question
        end
        format.js
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @question, notice: 'Answer has been successfully updated.' }
        format.js
      else
        format.html do
          flash[:alert] = 'Answer hasn`t been updated. Try again.'
          render :edit
        end
        format.js
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question_path(@question), notice: 'Your answer has been removed.' }
      format.js
    end
  end

  def best
    @answer = Answer.find(params[:id])
    if @question.user == current_user
      @answer.update_attributes(best: true)
      redirect_to @question, notice: 'Your has been made answer best'
    else
      flash[:alert] = "Unpermited action. Access denied."
      redirect_to @question
    end
  end

  private

  def check_authority
    unless @answer.user_id == current_user.id
      flash[:alert] = 'Unpermited action. Access denied.'
      redirect_to @answer.question
    end
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:text, :user_id, :question_id, attachments_attributes: [:id, :file, :_destroy])
  end
end
