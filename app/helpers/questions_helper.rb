module QuestionsHelper
  def check_authority(instance)
    instance.user == current_user
  end
end
