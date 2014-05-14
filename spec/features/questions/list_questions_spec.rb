require 'spec_helper'

feature 'Look list of questions', %q(
  In order to look questions at root page
  As an random user
  I want to be able to see questions
) do

  let(:questions) { create_list(:question, 10) }

  scenario 'Random user see list of questions at root page' do
    questions
    visit root_path
    save_and_open_page
    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.last.title
  end
end
