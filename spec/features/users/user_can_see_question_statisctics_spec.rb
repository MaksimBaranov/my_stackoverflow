require 'spec_helper'

feature 'Question Statistics', %q(
  In order to get info about question
  As an random user
  I would like to see statistics of question
) do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:votes) { build_list(:vote_with_value, 5) }
  given!(:answers) { create_list(:answer, 5) }
  given!(:user1) { create(:user) }
  given!(:user2) { create(:user) }

  background do
    user.questions << question
    user.answers << answers
    question.answers << answers
    question.votes << votes
  end

  scenario 'See count of answers' do
    visit root_path

    within "#statistics-#{question.id} .answers-count" do
      expect(page).to have_content 5
    end
  end

  scenario 'See count of votes' do
    visit root_path

    within "#statistics-#{question.id} .votes-count" do
      expect(page).to have_content 5
    end
  end
end
