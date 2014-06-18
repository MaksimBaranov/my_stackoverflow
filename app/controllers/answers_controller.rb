class AnswersController < InheritedResources::Base
  before_filter :authenticate_user!
  before_action :build_answer, only: :create
  respond_to :js, :html
  belongs_to :question
  load_and_authorize_resource

  def best
    if parent.user == current_user
      resource.update_attributes(best: true)
      redirect_to parent, notice: 'Your has been made answer best'
    else
      flash[:alert] = "Unpermited action. Access denied."
      redirect_to parent
    end
  end

  protected

  def build_answer
    build_resource.question = parent
  end

  def create_resource(object)
    object.user = current_user
    super
  end

  def answer_params
    params.require(:answer).permit(:text, :user_id, :question_id, attachments_attributes: [:id, :file, :_destroy])
  end
end
