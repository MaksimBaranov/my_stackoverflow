require 'spec_helper'

feature "Create question", %q{
  In order to get answer from SO
  As an authenticated user
  I want to be able to ask the question
} do

  scenario "Authenticated user create the question." do
    User.create!(email: "user@test.com", password: "12345678")

    visit new_user_session_path
    fill_in 'Email', with: "user@test.com"
    fill_in 'Password', with: "12345678"
    click_on 'Sign in'

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
