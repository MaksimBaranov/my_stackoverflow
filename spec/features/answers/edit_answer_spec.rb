require 'spec_helper'

feature 'Edit answer', %q(
  In order to edit content of answer
  As an authenticated user
  I want to be able to edit the answer
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }

  def  add_associations(user, question, answer)
    user.questions << question
    answer.question = question
  end

  scenario 'Authenticated user edit the answer.' do
    add_associations(user, question, answer)
    new_user_session
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on('Improve Answer')
    end
    fill_in 'Text', with: 'Some other text body answer.'*5
    #save_and_open_page
    click_on 'Edit Answer'

    expect(page).to have_content %q(Answer has been
     successfully updated.)
  end

  scenario 'Non-authenticated user try to edit question.' do
    add_associations(user, question, answer)
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on('Improve Answer')
    end

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
