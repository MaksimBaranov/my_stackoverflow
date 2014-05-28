require 'spec_helper'

feature 'Add files to answer', %q(
  In order to illustrate my answer
  As an  answer`s author
  I`d like to able to attach files
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) {create(:answer)}

  background do
    new_user_session
    visit question_path(question)
  end

  scenario 'User adds file when asks answer' do
    fill_in 'Text', with: answer.text
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end


