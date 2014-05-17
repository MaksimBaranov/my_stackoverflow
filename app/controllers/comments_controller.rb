class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_comment_object, only:  [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = comment_object
    if @comment.save
      redirect_to question_path(@question ||= @comment_object), notice: 'Your comment has been successfully created.'
    else
      flash[:alert] = 'Your comment hasn`t been created. Try again.'
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to question(@comment), notice: 'Your comment has been succesfully updated.'
    else
      flash[:alert] = 'Comment hasn`t been updated. Try again.'
      render :edit
    end
  end

  private

  def question(comment)
    if comment.commentable_type == 'Question'
      question_path(comment.commentable.id)
    else
      answer = comment.commentable
      question_path(answer.question.id)
    end
  end

  def set_comment_object
    case
    when params[:question_id]
      @comment_object = Question.find(params[:question_id])
    when params[:answer_id]
      @comment_object = Answer.find(params[:answer_id])
      @question = @comment_object.question
    end
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
