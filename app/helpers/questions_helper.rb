module QuestionsHelper
  def check_authority(instance)
    instance.user == current_user
  end

  def tag_urls(question)
    question.tags_list.map { |t| link_to t, tag_path(t)}.join(' ')
  end
end
