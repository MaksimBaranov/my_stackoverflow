require 'spec_helper'

feature 'Sign up(Registration)', %q(
  In order to be able part of community
  As an user
  I want to be able to sign up
) do

  given(:user) { create(:user) }

  scenario 'Non-existing user try to sign up' do

    visit new_user_registration_path
    fill_in 'Email', with: 'new@user.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Existing user try to sign in' do
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content %q(1 error prohibited this user
                                                          from being saved:)
  end
end
