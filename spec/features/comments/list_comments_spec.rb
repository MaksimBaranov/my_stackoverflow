require 'spec_helper'

feature 'Look at list of comments of question', %q(
  In order to look comments which related to question
  As a random user
  I want to be able to see comments
) do

  let(:question) { create(:question) }
  let(:answers) { create_list(:answer, 5) }
  let(:comments) { create_list(:comment, 5) }

  scenario 'Random user see list of comments which related at question' do
    question.comments << comments
    visit question_path(question)
    expect(page).to have_content comments.first.text
    expect(page).to have_content comments.last.text
  end
  scenario 'Random user see list of comments for answers' do
    answers.each do |answer|
      answer.comments << comments
    end
    question.answers << answers
    visit question_path(question)
    expect(page).to have_content comments.first.text
    expect(page).to have_content comments.last.text
  end
end
