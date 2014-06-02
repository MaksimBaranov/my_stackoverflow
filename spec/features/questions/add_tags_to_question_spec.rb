require 'spec_helper'

feature 'Add tags to question', %q(
In order to improve search of answers
As an authenticate user
I would to add tags to question
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:tag) { create(:tag) }


  scenario 'Create question and add new tag', js: true do
    new_user_session
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: question.title
    fill_in 'Text', with: question.body
    click_on 'Remove this file'
    fill_in 'Tag', with: 'Rails, Javascript, Cofeescript, Ruby'
    click_on 'Create'
    expect(page).to have_content('Rails Javascript Cofeescript Ruby')
  end
end
