class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_question

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to root_path, notice: 'Your comment has been successfully created.'
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
