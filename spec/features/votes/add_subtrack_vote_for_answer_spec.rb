require 'spec_helper'

feature 'Voting', %q(
  In order to vote for information
  As an authenticated user
  I want to be able to votes for answer
) do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  before(:each) { question.answers << answer }

  scenario 'Authenticated user add voice to answer', js: true  do
    new_user_session

    visit question_path(question)
    within "#vote-#{answer.class.name.downcase}-#{answer.id}" do
      click_on 'Up Vote'

      within "#vote-#{answer.class.name.downcase}-#{answer.id} .vote-count" do
        expect(page).to have_content  1
      end
    end
  end

  scenario 'Authenticated user subtract voice to answer', js: true do
    new_user_session

    visit question_path(question)
    within "#vote-#{answer.class.name.downcase}-#{answer.id}" do
      click_on 'Down Vote'

      within "#vote-#{answer.class.name.downcase}-#{answer.id} .vote-count" do
        expect(page).to have_content  -1
      end
    end
  end

  scenario "Authenticated user cancel his voice for answer", js: true do
    new_user_session

    visit question_path(question)
    within "#vote-#{answer.class.name.downcase}-#{answer.id}" do
      click_on 'Down Vote'

      within "#vote-#{answer.class.name.downcase}-#{answer.id} .vote-count" do
        expect(page).to have_content  0
      end
    end
  end

  scenario 'Non-authenticated user try to up vote' do

    visit question_path(question)
    within "#vote-#{answer.class.name.downcase}-#{answer.id}" do
      click_on 'Up Vote'
    end
    expect(page).to have_button 'Sign in'
  end

  scenario 'Non-authenticated user try to down vote' do

    visit question_path(question)
    within "#vote-#{answer.class.name.downcase}-#{answer.id}" do
      click_on 'Down Vote'
    end
    expect(page).to have_button 'Sign in'
  end
end
