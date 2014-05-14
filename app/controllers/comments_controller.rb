class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_comment_object

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = @comment_object
    if @comment.save
      redirect_to question_path(@question ||= @comment_object), notice: 'Your comment has been successfully created.'
    else
      flash[:alert] = 'Your comment hasn`t been created. Try again.'
      render :new
    end
  end

  private

  # def question
  #   @question = Question.find(params[:question_id])
  # end

  def set_comment_object
    case
    when params[:question_id]
      @comment_object = Question.find(params[:question_id])
    when params[:answer_id]
      @comment_object = Answer.find(params[:answer_id])
      @question = @comment_object.question
    end
  end

  def comment_params
    params.require(:comment).permit(:text, :commentable_id, :commentable_type, :user_id)
  end
end
