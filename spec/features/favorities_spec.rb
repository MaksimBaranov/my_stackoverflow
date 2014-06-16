require 'spec_helper'

feature 'Add to Favorities', %q(
  In order to store usefull information
  As an authenticated user
  I want to be able to add info to favorites
) do

given!(:user) { create(:user) }
given!(:question) { create(:question) }
given!(:answer) { create(:answer) }
given!(:favorite) { create(:favorite) }

scenario 'User sees favour link which related to questions' do
  new_user_session
  visit question_path(question)

  within "#favorites-question-id-#{question.id}" do
    expect(page).to have_link 'Add to Favorites'
  end
end
scenario 'User sees favour link which related to answers' do
  new_user_session
  question.answers << answer
  visit question_path(question)

  within "#favorites-answer-id-#{answer.id}" do
    expect(page).to have_link 'Add to Favorites'
  end
end

scenario 'User adds question to favourities' do
  new_user_session
  visit question_path(question)
  within "#favorites-question-id-#{question.id}" do
    click_on 'Add to Favorites'
    user.favorites << favorite
    question.favorites << favorite

    save_and_open_page
    within '.favorites' do
      expect(page).to have_content 'Favorite'
    end
  end
end

scenario 'User adds answer to favorites' do
  new_user_session
  question.answers << answer
  visit question_path(question)
  within "#favorites-answer-id-#{answer.id}" do
    click_on 'Add to Favorites'
    user.favorites << favorite
    answer.favorites << favorite

    save_and_open_page
    within '.favorites' do
      expect(page).to have_content 'Favorite'
    end
  end
end

scenario 'Non-authenticated user try to add to favorites' do
  visit question_path(question)

  expect(page).to_not have_link 'Add to Favorites'
end
end
