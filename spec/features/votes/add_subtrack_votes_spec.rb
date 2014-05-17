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
    within '.vote-count' do
      expect(page).to have_content "#{vote.quallity + 1}"
    end
  end

  scenario 'Authenticated user subtract voice' do
  end

  scenario 'Non-authenticated user try to vote' do
  end
end
