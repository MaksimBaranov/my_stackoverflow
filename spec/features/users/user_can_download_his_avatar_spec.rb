require 'spec_helper'

feature 'Download Avatar', %q(
  In order to attach avatar to my profile
  As an authenticated user
  I would like to download avatar to user
) do

  given(:user) { create(:user) }

  background do
    new_user_session
  end

  scenario "usen can upload own avatar" do
    pending('some features need reduction')
  end


end
