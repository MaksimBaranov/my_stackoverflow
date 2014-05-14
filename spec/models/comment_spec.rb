require 'spec_helper'

describe Comment do
  it { should belong_to(:commentable) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:text) }
  it { should ensure_length_of(:text).is_at_least(20).is_at_most(600) }
end
