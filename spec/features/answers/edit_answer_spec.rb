require 'spec_helper'

feature 'Edit answer', %q(
  In order to edit content of answer
  As an authenticated user
  I want to be able to edit the answer
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }


  scenario 'Authenticated user edit the answer.' do
    new_user_session
    visit question_path(question)
    fill_in 'Text', with: answer.text
    click_on 'Post Your Answer'
    find("a[href='#{edit_question_answer_path(question, answer)}']")
    save_and_open_page


    # click_on("a[href='#{edit_question_answer_path(question,answer)}']")
    #  fill_in 'Text', with: 'Some other text body answer.'*5
    #  click_on 'Edit Answer'

    expect(page).to have_content %q(Your answer has been
     successfully updated.)
  end

  # scenario 'Non-authenticated user try to edit question.' do
  #   visit question_path(question)
  #   click_on 'Improve Answer1'

  #   expect(page).to have_content %q(You need to sign in
  #   or sign up before continuing.)
  # end
end
