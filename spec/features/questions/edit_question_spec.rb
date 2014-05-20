require 'spec_helper'

feature 'Edit question', %q(
  In order to edit content of my own question
  As an authenticated user
  I want to be able to edit the question
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  def auth_user_is_author_of_question
    user.questions << question
    new_user_session
  end

  scenario 'Authenticated user see edit-question-button' do
    auth_user_is_author_of_question
    visit question_path(question)

    expect(page).to have_content 'Improve Question'
   end

  scenario 'Authenticated user edit the question.' do
    auth_user_is_author_of_question
    visit question_path(question)
    click_on 'Improve Question'
    fill_in 'Title', with: 'Some other text title`s question.'
    fill_in 'Text', with: 'Some other text body question.'*5
    click_on 'Edit Question'

    expect(page).to have_content %q(Your question has been
     successfully updated.)
  end

  scenario 'Non-authenticated user try to edit question from address bar.' do
    visit edit_question_path(question)

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
