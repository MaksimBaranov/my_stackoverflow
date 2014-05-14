require 'spec_helper'

feature 'Add comment for answer', %q(
  In order to comment smb answer
  As an authenticated user
  I want to be able to create comment
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }
  given(:comment) { create(:comment) }

  def  user_has_question_with_answer
    user.questions << question
    answer.question = question
  end

  scenario 'Authenticated user create comment' do
    user_has_question_with_answer
    new_user_session
    visit question_path(question)
    save_and_open_page

    within "#answer-#{answer.id}" do
      click_on('Add Comment')
    end
    fill_in 'Text', with: comment.text
    click_on 'Create Comment'

    expect(page).to have_content 'Your comment has been successfully created.'
  end

  scenario 'Unauthenticated user try to create comment' do
    user_has_question_with_answer
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on('Add Comment')
    end
  end
end
