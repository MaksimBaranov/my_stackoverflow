class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_comment_object, only:  [:new, :create]
  before_filter :load_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = @comment_object
    if @comment.save
      redirect_to @comment.question, notice: 'Your comment has been successfully created.'
    else
      flash[:alert] = 'Your comment hasn`t been created. Try again.'
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.question, notice: 'Your comment has been succesfully updated.'
    else
      flash[:alert] = 'Comment hasn`t been updated. Try again.'
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.question, notice: 'Your comment has been removed.'
  end

  private

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def set_comment_object
    parent = %w(questions answers).find {|p| request.path.split('/').include? p }[0..-2]
    @comment_object = parent.classify.constantize.find(params["#{parent}_id"])
  end

  def comment_params
    params.require(:comment).permit(:text, :commentable_id, :commentable_type, :user_id)
  end
end
