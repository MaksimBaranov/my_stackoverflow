require 'spec_helper'

feature 'Add comment for question', %q(
  In order to comment smb question
  As an authenticated user
  I want to be able to create comment
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:comment) { create(:comment) }

  scenario 'Authenticated user create the comment' do
    new_user_session
    visit question_path(question)
    within '.list-question-comments' do
      click_on 'Add Comment'
    end
    fill_in 'Text', with: comment.text
    click_on 'Create Comment'

    expect(page).to have_content('Your comment has been successfully created.')
  end

  scenario 'Non-authenticated user try to create comment' do
    visit question_path(question)
    within '.list-question-comments' do
      click_on('Add Comment')
    end

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
