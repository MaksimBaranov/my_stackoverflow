require 'spec_helper'

feature 'Create question', %q(
  In order to get answer from SO
  As an authenticated user
  I want to be able to ask the question
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create the question.', js: true do
    new_user_session
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: question.title
    fill_in 'Text', with: question.body
    click_on 'Create'
    within '.list-questions' do
      expect(page).to have_content question.title
    end
  end

  describe "Non-authenticated user" do
    scenario "doesn't see create question link" do
      visit questions_path

      expect(page).to_not have_content 'Ask question'
      expect(page).to have_content 'Login to ask question'
    end

    scenario 'try to create question through address bar.' do
      visit new_question_path

      expect(page).to have_content %q(You need to sign in
      or sign up before continuing.)
    end
  end
end
