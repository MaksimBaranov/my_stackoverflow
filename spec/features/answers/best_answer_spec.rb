require 'spec_helper'

feature 'The best answer', %q(
  In order to specify the best answer
  As an author of question
  I would like to choose the best answer
) do

  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  def  question_has_answer
    user.questions << question
    answer.question = question
    answer.save
  end

  describe 'Authenticated user' do
    describe 'is author of question' do
      scenario 'see link make best answer' do
        question_has_answer
        new_user_session
        visit question_path(question)
        save_and_open_page

        expect(page).to have_link 'Make Best'
      end
      scenario 'try to add preference to answer' do
        question_has_answer
        new_user_session
        visit question_path(question)
        click_on 'Make Best'

        expect(page).to have_content 'Best Answer'
      end
    end
    describe 'is user who is not author of question' do
      scenario 'does not see link make best answer' do
        question_has_answer
        new_another_user_session another_user
        visit question_path question

        expect(page).to_not have_link 'Make Best'
      end
    end
  end

  describe 'Non-authenticated user' do
    scenario 'does not see link-choose-best' do
      question_has_answer
      visit question_path question

      expect(page).to_not have_link 'Make Best'
    end
  end
end
