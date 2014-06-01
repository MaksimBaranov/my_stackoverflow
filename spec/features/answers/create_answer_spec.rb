require 'spec_helper'

feature 'Create answer', %q(
  In order to answer  the question
  As an authenticated user
  I want to be able to write the answer
  ) do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }


  scenario 'Authenticated user create the answer', js: true do
    new_user_session
    visit question_path(question)
    fill_in 'Text', with: answer.text
    click_on 'Remove this file'
    click_on 'Post Your Answer'
    expect(page).to have_content answer.text
  end

  scenario 'Non-authenticated user try to create answer' do
    visit question_path(question)
    click_on 'Post Your Answer'

    expect(page).to have_content 'You need to sign in or
                                                  sign up before continuing.'
  end
end
