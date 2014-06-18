require 'spec_helper'

feature 'Voting', %q(
  In order to vote for information
  As an authenticated user
  I want to be able to votes for question
) do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  scenario 'Authenticated user add voice to question', js: true  do
    new_user_session

    visit question_path(question)
    within "#vote-#{question.class.name.downcase}-#{question.id}" do
      click_on 'Up Vote'

      within "#vote-#{question.class.name.downcase}-#{question.id} .vote-count" do
        expect(page).to have_content  1
      end
    end
  end

  scenario 'Authenticated user subtract voice to question', js: true do
    new_user_session

    visit question_path(question)
    within "#vote-#{question.class.name.downcase}-#{question.id}" do
      click_on 'Down Vote'

      within "#vote-#{question.class.name.downcase}-#{question.id} .vote-count" do
        expect(page).to have_content  -1
      end
    end
  end

  scenario "Authenticated user cancel his voice for question", js: true do
    new_user_session
    visit question_path(question)
    within "#vote-#{question.class.name.downcase}-#{question.id}" do
      click_on 'Down Vote'

      within "#vote-#{question.class.name.downcase}-#{question.id} .vote-count" do
        expect(page).to have_content  0
      end
    end
  end

  scenario 'Non-authenticated user try to up vote' do

    visit question_path(question)
    within "#vote-#{question.class.name.downcase}-#{question.id}" do
      click_on 'Up Vote'
    end
    expect(page).to have_button 'Sign in'
  end

  scenario 'Non-authenticated user try to down vote' do

    visit question_path(question)
    within "#vote-#{question.class.name.downcase}-#{question.id}" do
      click_on 'Down Vote'
    end
    expect(page).to have_button 'Sign in'
  end
end
