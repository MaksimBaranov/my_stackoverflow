require 'spec_helper'

describe Answer do
  it { should belong_to(:user) }
  it { should belong_to(:question) }
  it { should belong_to(:vote) }
  it { should have_many(:comments) }
  it { should validate_presence_of :text }
  it { should ensure_length_of(:text).is_at_least(10).is_at_most(600) }
end
