require 'spec_helper'

feature 'Look list answers', %q(
  In order to look answers which related to question
  As an random user
  I want to be able to see answers
) do

  let(:question) { create(:question) }
  let(:answers) { create_list(:answer,10) }

  scenario 'Random user see list of answers to current question.' do
    question.answers << answers
    visit question_path(question)
    expect(page).to have_content answers.first.text
    expect(page).to have_content answers.last.text
  end
end
