class QuestionsController < InheritedResources::Base
  impressionist actions: [:show]
  # custom_actions collection: [:voted, :popular, :unanswered, :newest]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_question, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def destroy
    destroy!( notice: 'Your question has been removed.' ) { questions_path }
  end

  protected

  def collection
      @questions ||= end_of_association_chain.eager_loading.with_tag(params[:tag]) if params[:tag]
      @questions ||= end_of_association_chain.eager_loading.send params[:sort_by] if params[:sort_by]
      @questions ||= end_of_association_chain.eager_loading.all
  end

  def create_resource(object)
    object.user = current_user
    super
  end

  def load_question
    @question = Question.includes(:attachments, {comments: :user}, answers: [:attachments, {comments: :user}, :user]).find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id, :tag_names, attachments_attributes: [:id, :file, :_destroy] )
  end
end
