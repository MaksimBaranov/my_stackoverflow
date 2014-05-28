require 'spec_helper'

feature 'Add files to questions', %q(
  In order to illustrate my question
  As an question`s author
  I want to be able to attach files
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    new_user_session
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: question.title
    fill_in 'Text', with: question.body
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
