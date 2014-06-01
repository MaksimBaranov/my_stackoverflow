require 'spec_helper'

feature 'Look list of users', %q(
  In order to look info users at SO
  As an random user
  I want to be able to see list of all users
) do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:users) { create_list(:user, 10) }
  background do
    new_user_session
    users
  end

  describe 'Authentcicated user' do
    scenario 'see list of users ' do
      visit root_path
      click_on 'Users'
      expect(page).to have_content users.first.email
      expect(page).to have_content users.last.email
    end

    scenario "can`t see edit-user-button profile alians user" do
      visit user_path(:another_user)
      expect(page).to_not have_link 'Edit User Profile', href: edit_user_registration_path
    end
  end

end
