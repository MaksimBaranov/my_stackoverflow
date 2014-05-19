require 'spec_helper'

feature 'Voting', %q(
  In order to vote for information
  As an authenticated user
  I want to be able to votes for question
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }
  given(:vote) { create(:vote) }

  scenario 'Authenticated user add voice' do
    question.create_vote
    new_user_session

    visit question_path(question)
    within "#vote-question-#{question.vote.id}" do
      click_on 'Up Vote'
    end
    expect(page).to have_content "Your voice has been added."
  end

  scenario 'Authenticated user subtract voice' do
    question.create_vote
    new_user_session

    visit question_path(question)
    within "#vote-question-#{question.vote.id}" do
      click_on 'Down Vote'
    end
    expect(page).to have_content "You have subtracted voice."
  end

  scenario 'Non-authenticated user try to up vote' do
    question.create_vote

    visit question_path(question)
    within "#vote-question-#{question.vote.id}" do
      click_on 'Up Vote'
    end
    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end

  scenario 'Non-authenticated user try to down vote' do
    question.create_vote

    visit question_path(question)
    within "#vote-question-#{question.vote.id}" do
      click_on 'Down Vote'
    end
    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
