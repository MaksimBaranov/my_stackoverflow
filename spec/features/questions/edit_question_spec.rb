require 'spec_helper'

feature 'Edit question', %q(
  In order to edit content of my question
  As an authenticated user
  I want to be able to edit the question
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user edit the question.' do
    new_user_session
    visit question_path(question)
    click_on 'Improve Question'
    fill_in 'Title', with: 'Some other text title`s question.'
    fill_in 'Text', with: 'Some other text body question.'
    click_on 'Edit Question'

    expect(page).to have_content %q(Your question has been
     successfully updated.)
  end

  scenario 'Non-authenticated user try to edit question.' do
    visit question_path(question)
    click_on 'Improve Question'

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
