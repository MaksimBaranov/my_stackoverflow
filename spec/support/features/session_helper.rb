require 'spec_helper'

module Features
  # Module for sharing repeated functional for user.
  module SessionHelpers
    def new_user_session
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Sign in'
    end

    def new_another_user_session(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Sign in'
    end
  end
end
