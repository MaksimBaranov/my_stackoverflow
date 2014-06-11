class CommentsController < InheritedResources::Base
  respond_to :js
  before_filter :authenticate_user!
  actions :all
  belongs_to :answer, :question, polymorphic: true, :optional => true

  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def comment_params
    params.require(:comment).permit(:text, :commentable_id, :commentable_type, :user_id)
  end
end
