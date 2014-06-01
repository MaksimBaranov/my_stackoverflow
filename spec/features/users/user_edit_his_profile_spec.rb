require 'spec_helper'

feature 'Show user profile', %q(
  In order to add changes to his profile
  As an owner of profile
  I would like to edit my profile
) do

  given(:user) { create(:user) }

  background do
    new_user_session
  end

  scenario 'Authenticated user see link to his profile ' do
    visit root_path

    expect(page).to have_link 'Your profile', href: user_path(user)
  end

  scenario 'Authenticated user look his profile' do
    visit user_path(user)

    expect(page).to have_content user.email
    expect(page).to have_link 'Edit Your Profile', href: edit_user_registration_path
  end

  scenario 'Authenticated user try edit email' do
    visit edit_user_registration_path(user)
    fill_in 'Email', with: "new_email@mail.ru"
    fill_in 'Current password', with: user.password
    click_on 'Update'

    expect(page).to have_content 'You updated your account successfully.'
  end
end
