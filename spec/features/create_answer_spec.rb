require 'spec_helper'

feature 'Create answer', %q(
  In order to answer  the question
  As an authenticated user
  I want to be able to write the answer
  ) do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  scenario 'Authenticated user create the answer' do
    new_user_session
    visit question_path(question)
    click_on 'Post Your Answer'
    fill_in 'Text', with: 'Some answer text.'
    click_on 'Create'

    expect(page).to have_content 'Your answer is successfuly created.'
  end

  scenario 'Non-authenticated user try to create answer' do
    visit question_path(question)
    click_on 'Post Your Answer'

    expect(page).to have_content 'You need to sign in or
                                                  sign up before continuing.'
  end
end
