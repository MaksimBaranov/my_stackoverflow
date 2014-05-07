require 'spec_helper'

feature "Create question", %q{
  In order to get answer from SO
  As an authenticated user
  I want to be able to ask the question
} do

  let(:user) {create(:user)}

  scenario "Authenticated user create the question." do
    new_user_session
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'My title question.'
    fill_in 'Text', with: 'My text of question.'
    click_on 'Create'
    expect(page).to have_content 'Your question is successfully created.'
  end

  scenario 'Non-authenticated user try to create question.' do
    visit questions_path
    click_on 'Ask question'

    #save_and_open_page
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
