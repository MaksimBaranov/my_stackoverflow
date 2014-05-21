require 'spec_helper'

feature 'Delete question', %q(
  In order to delete my own question
  As an authenticated user
  I want to be able to delete the question
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  def auth_user_is_author_of_question
    user.questions << question
    new_user_session
  end

  scenario 'Authenticated user see delete-question-button' do
    auth_user_is_author_of_question
    visit question_path(question)

    expect(page).to have_content 'Delete Question'
  end

  scenario 'Authenticated user delete the question' do
    auth_user_is_author_of_question
    visit question_path(question)
    click_on 'Delete Question'

    expect(page).to have_content 'Your question has been removed.'
  end
end
