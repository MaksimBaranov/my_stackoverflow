require 'spec_helper'

feature 'Edit answer', %q(
  In order to edit content of my own answer
  As an authenticated user
  I want to be able to edit the answer
) do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  def  question_has_answer
    answer.question = question
    answer.save
  end

  def auth_user_is_author_of_answer
    user.answers << answer
    new_user_session
  end

  describe 'Authenticated user' do
    background(:each) do
      question_has_answer
      auth_user_is_author_of_answer
      visit question_path(question)
    end

    scenario 'see edit-link his answer' do
      within "#answer-#{answer.id}" do
        expect(page).to have_link 'Improve Answer'
      end
    end

    scenario 'try to edit his answer', js: true do
      within "#answer-#{answer.id}" do
        click_on('Improve Answer')
        fill_in 'Text', with: 'Some other text body answer.'*5
        click_on 'Edit Answer'

        expect(page).to_not have_content answer.text
        expect(page).to have_content 'Some other text body answer.'*5
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'try to edit alies answer through address bar'
  end
  # scenario 'Authenticated user see edit-answer-button.' do
  #   question_has_answer
  #   auth_user_is_author_of_answer
  #   visit question_path(question)

  #   within "#answer-#{answer.id}" do
  #     expect(page).to have_content 'Improve Answer'
  #   end
  # end

  # scenario 'Authenticated user edit the answer.' do
  #   question_has_answer
  #   auth_user_is_author_of_answer
  #   visit question_path(question)
  #   within "#answer-#{answer.id}" do
  #     click_on('Improve Answer')
  #   end
  #   fill_in 'Text', with: 'Some other text body answer.'*5
  #   click_on 'Edit Answer'

  #   expect(page).to have_content %q(Answer has been
  #    successfully updated.)
  # end

  describe 'Non-authenticated user' do
    scenario "doesn't see link edit answer" do
      question_has_answer
      expect(page).to_not have_link 'Improve Answer'
    end

    scenario 'try to edit answer through address bar' do
      question_has_answer
      visit edit_question_answer_path(question, answer)

      expect(page).to have_content %q(You need to sign in
      or sign up before continuing.)
    end
  end

end
