require 'spec_helper'

feature "Create answer", %q{
  In order to answer  the question
  As an authenticated user
  I want to be able to write the answer
  } do
  let(:user) {create(:user)}

  scenario "Authenticated user create the answer" do
    new_user_session
  end

  scenario "Non-authenticated user try to create answer" do

  end
end
