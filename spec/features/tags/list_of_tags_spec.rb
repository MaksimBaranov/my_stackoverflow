require 'spec_helper'

feature 'List of Tags', %q(
  In order to find question more fast
  As an ranfom user
  I would like to see list of tags
) do

  given!(:tags) { create_list(:tag, 10)}

  scenario 'Random user see tag list' do
    visit tags_path
    expect(page).to have_content tags.first.name
    expect(page).to have_content tags.last.name
  end
end
