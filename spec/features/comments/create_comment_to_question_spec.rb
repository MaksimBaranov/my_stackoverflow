require 'spec_helper'

feature 'Add comment for question', %q(
  In order to comment smb question
  As an authenticated user
  I want to be able to create comment
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create the comment' do
  end

  scenario 'Non-authenticated user try to create comment' do
    visit questions_path(question)
    click_on 'Add comment'

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
