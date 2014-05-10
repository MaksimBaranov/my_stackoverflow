require 'spec_helper'

feature 'Show question', %q(
  In order to get answer
  As an random user
  I want to be able look into question
) do

  let(:question) { create(:question) }

  scenario 'Random user look current question.' do
    visit question_path(question)
    expect(page).to have_content question.body
  end
end
