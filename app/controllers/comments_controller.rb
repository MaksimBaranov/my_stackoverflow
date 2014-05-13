class CommentsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @comment = Comment.new
    @question = Question.find(params[:question_id])
  end

  def create

  end
end
