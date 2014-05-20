require 'spec_helper'

feature 'Edit comment', %q(
  In order to edit my own comment to question/answer
  As an authenticated user
  I want to be able to edit comment
) do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }
  given!(:comment1) { create(:comment) }
  given!(:comment2) { create(:comment) }

  def question_and_answer_have_comments
    answer.question = question
    answer.save
    question.comments << comment1
    answer.comments << comment2
  end

  def auth_user_is_author_of_question_and_answer
    user.questions << question
    user.answers << answer
    user.comments << [comment1, comment2]
    new_user_session
  end

  scenario 'Authenticated user see edit-button for answer and question.' do
    question_and_answer_have_comments
    auth_user_is_author_of_question_and_answer
    visit question_path(question)

    within ".list-question-comments #comment-#{comment1.id}" do
      expect(page).to have_content 'Improve Comment'
    end

    within "#answer-#{answer.id} #comment-#{comment2.id}" do
      expect(page).to have_content 'Improve Comment'
    end
  end

  scenario 'Authenticated user edit comment for answer' do
    question_and_answer_have_comments
    auth_user_is_author_of_question_and_answer
    visit question_path(question)
    within "#answer-#{answer.id} #comment-#{comment2.id}" do
      click_on('Improve Comment')
    end
    fill_in 'Text', with: comment2.text
    click_on 'Edit Comment'

    expect(page).to have_content %q(Your comment has been succesfully updated.)
  end

  scenario 'Authenticated user edit comment for question' do
    question_and_answer_have_comments
    auth_user_is_author_of_question_and_answer
    visit question_path(question)
    within ".list-question-comments #comment-#{comment1.id}" do
      click_on('Improve Comment')
    end
    fill_in 'Text', with: comment2.text
    click_on 'Edit Comment'

    expect(page).to have_content %q(Your comment has been succesfully updated.)
  end

  scenario 'Non-authenticated user try to edit comment from address bar.' do
    question_and_answer_have_comments
    visit edit_comment_path(comment1 ||= comment2)

    expect(page).to have_content %q(You need to sign in
    or sign up before continuing.)
  end
end
