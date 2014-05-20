module QuestionsHelper
  def check_authority(instance, current_user)
    instance.user == current_user
  end
end
