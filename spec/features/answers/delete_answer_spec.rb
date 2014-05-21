require 'spec_helper'

feature 'Delete answer', %q(
  In order to delete my own answer
  As an authenticated user
  I want to be able to delete the answer
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }

  def auth_user_is_author_of_answer
    user.questions << question
    user.answers << answer
    question.answers << answer
    new_user_session
  end

  scenario 'Authenticated user see delete-answer-button' do
    auth_user_is_author_of_answer
    visit question_path(question)
    within "#answer-#{answer.id}" do
      expect(page).to have_content 'Delete Answer'
    end
  end

  scenario 'Authenticated user delete the answer' do
    auth_user_is_author_of_answer
    visit question_path(question)
      click_on 'Delete Answer'

    expect(page).to have_content 'Your answer has been removed.'
  end
end
