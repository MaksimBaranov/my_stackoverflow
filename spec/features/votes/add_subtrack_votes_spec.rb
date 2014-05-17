require 'spec_helper'

feature 'Voting', %q(
  In order to vote for information
  As an authenticated user
  I want to be able to votes for question/answer
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }
  given(:vote) { create(:vote) }

  scenario 'Authenticated user add voice ' do
    new_user_session

    visit question_path(question)
    click_on 'Up Vote'
    expect(page).to have_content "Your voice has been added"
  end

  scenario 'Authenticated user subtract voice' do
    new_user_session
    question.answers << answer
    visit question_path(question)
    click_on 'Up Vote'
    expect(page).to have_content "You have subtracted voice."
  end

  scenario 'Non-authenticated user try to up vote' do
    visit questions_path
    click_on 'Up Vote'

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end

  scenario 'Non-authenticated user try to down vote' do
    visit questions_path
    click_on 'Down Vote'

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
