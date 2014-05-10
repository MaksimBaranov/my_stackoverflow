require 'spec_helper'

feature 'Sign out(Exit)', %q{
  In order to be able leave my account
  As an user
  I want to be able to sign out
} do

  given(:user){ create(:user) }

  scenario "Signed in user try to exit account" do
    new_user_session

    click_on 'Sign out'
    expect(page).to have_content "Signed out successfully."
  end
end
