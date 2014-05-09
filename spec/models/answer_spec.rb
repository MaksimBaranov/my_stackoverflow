require 'spec_helper'

describe Answer do
  it { should belong_to(:user) }
  it { should belong_to(:question) }
  it { should validate_presence_of :text }
  it { should ensure_length_of(:text).is_at_least(50).is_at_most(600) }
end
