require 'spec_helper'

feature 'Edit comment', %q(
  In order to edit my comment to question/answer
  As an authenticated user
  I want to be able to edit comment
) do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }
  given!(:comment1) { create(:comment) }
  given!(:comment2) { create(:comment) }

  def init_question_answer_comment
    answer.question = question
    answer.save
    question.comments << comment1
    answer.comments << comment2
  end

  scenario 'Authenticated user edit comment for answer' do
    init_question_answer_comment

    new_user_session
    visit question_path(question)
    within "#answer-#{answer.id} #comment-#{comment2.id}" do
      click_on('Improve Comment')
    end
    fill_in 'Text', with: comment2.text
    click_on 'Edit Comment'
    expect(page).to have_content %q(Your comment has been succesfully updated.)
  end

  scenario 'Authenticated user edit comment for question' do
    init_question_answer_comment

    new_user_session
    visit question_path(question)
    within ".list-question-comments #comment-#{comment1.id}" do
      click_on('Improve Comment')
    end
    fill_in 'Text', with: comment2.text
    click_on 'Edit Comment'
    expect(page).to have_content %q(Your comment has been succesfully updated.)
  end

  scenario 'Non-authenticated user try to edit comment' do
    init_question_answer_comment
    visit question_path(question)
    within "#answer-#{answer.id} #comment-#{comment2.id}" do
      click_on('Improve Comment')
    end

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
