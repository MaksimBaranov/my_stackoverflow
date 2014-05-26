require 'spec_helper'

feature 'Delete answer', %q(
  In order to delete my own answer
  As an authenticated user
  I want to be able to delete the answer
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }

  def user_has_answer_question
    user.questions << question
    user.answers << answer
    question.answers << answer
  end

  describe 'Authenticated user' do
    scenario 'see delete-link his answer' do
      user_has_answer_question
      new_user_session
      visit question_path(question)
      within "#answer-#{answer.id}" do
        expect(page).to have_link 'Delete Answer'
      end
    end

    scenario 'try to edit his answer', js: true do
      user_has_answer_question
      new_user_session
      visit question_path(question)

      within "#answer-#{answer.id}" do
        click_on('Delete Answer')
      end
      expect(page).to_not have_content answer.text
    end
  end

  describe 'Non-authenticated user' do
    scenario "doesn't see delete-link answer" do
      user_has_answer_question
      visit question_path(question)

      expect(page).to_not have_content('Delete Answer')
    end
  end
end
