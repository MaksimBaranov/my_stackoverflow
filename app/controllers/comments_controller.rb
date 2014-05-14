class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_question

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @question.comments << @comment
    if @comment.save
      redirect_to question_path(@question), notice: 'Your comment has been successfully created.'
    else
      flash[:alert] = 'Your comment hasn`t been created. Try again.'
      render :new
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :commentable_id, :commentable_type, :user_id)
  end
end
