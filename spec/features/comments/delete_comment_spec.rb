require 'spec_helper'

feature 'Delete comment', %q(
  In order to delete my own comment from question/answer
  As an authenticated user
  I want to be able to delete comment
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

  scenario 'Authenticated user see delete-button-comment for answer and question.' do
    question_and_answer_have_comments
    auth_user_is_author_of_question_and_answer
    visit question_path(question)

    within ".list-question-comments #comment-#{comment1.id}" do
      expect(page).to have_content 'Delete Comment'
    end

    within "#answer-#{answer.id} #comment-#{comment2.id}" do
      expect(page).to have_content 'Delete Comment'
    end
  end

  scenario 'Authenticated user delete comment for answer', js: true do
    question_and_answer_have_comments
    auth_user_is_author_of_question_and_answer
    visit question_path(question)
    within "#answer-#{answer.id} #comment-#{comment2.id}" do
      click_on('Delete Comment')
    end

    within '.list-answer-comments' do
      expect(page).to_not have_content comment2.text
    end
  end

  scenario 'Authenticated user delete comment for question', js: true do
    question_and_answer_have_comments
    auth_user_is_author_of_question_and_answer
    visit question_path(question)
    within ".list-question-comments #comment-#{comment1.id}" do
      click_on('Delete Comment')
    end

    within '.list-question-comments' do
      expect(page).to_not have_content comment1.text
    end
  end
end
