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
      redirect_to question_path(@question ||= @comment_object), notice: 'Your comment has been successfully created.'
    else
      flash[:alert] = 'Your comment hasn`t been created. Try again.'
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to question(@comment), notice: 'Your comment has been succesfully updated.'
    else
      flash[:alert] = 'Comment hasn`t been updated. Try again.'
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to question(@comment), notice: 'Your comment has been removed.'
  end

  private

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def question(comment)
    if comment.commentable_type == 'Question'
      question_path(comment.commentable.id)
    else
      answer = comment.commentable
      question_path(answer.question.id)
    end
  end

  def set_comment_object
    @comment_object = Question.find(params[:question_id]) if params[:question_id]
    @comment_object ||= Answer.find(params[:answer_id])
    @question = @comment_object.question if params[:answer_id]
  end

  # def parent
  #   @parent ||= %w(question answer).find {|p| request.path.split('/').include? p }
  # end

  # def parent_class
  #   parent.classify.constantize
  # end

  # def comment_object
  #   @comment_object ||= parent_class.find(params["#{parent}_id"])
  # end

  # def current_question
  #   if parent == 'Question'
  #     comment_object
  #   else
  #     commentable.question
  #   end
  # end

  def comment_params
    params.require(:comment).permit(:text, :commentable_id, :commentable_type, :user_id)
  end
end
