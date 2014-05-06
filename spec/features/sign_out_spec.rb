require 'spec_helper'

feature 'Sign out(Exit)', %q{
  In order to be able leave my account
  As an user
  I want to be able to sign out
} do

  let(:user){user = create(:user)}

  scenario "Signed in user try to exit account" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'

    click_on 'Sign out'
    save_and_open_page
    expect(page).to have_content "Signed out successfully."

  end
end
