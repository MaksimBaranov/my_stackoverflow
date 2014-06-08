require 'spec_helper'

feature 'Question Statistics', %q(
  In order to get info about question
  As an random user
  I would like to see statistics of question
) do

  given(:question) { create(:question) }
  given(:answers) { create_list(:answer, 10) }
  given!(:votes) { create_list(:vote, 10) }
  given!(:user1) { create(:user) }
  given!(:user2) { create(:user) }

  scenario 'See count of answers' do
    question.answers << answers
    visit root_path

    save_and_open_page
    within "#statistics-#{question.id} .answers-count" do
      expect(page).to have_content 10
    end
  end

  scenario 'See count of votes' do
    question.vote << votes
    visit root_path

    within "#statistics-#{question.id} .votes-count" do
      expect(page).to have_content 10
    end
  end
end
