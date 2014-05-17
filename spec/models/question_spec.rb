require 'spec_helper'

describe Question do
  it { should belong_to(:user) }
  it { should belong_to(:vote) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should ensure_length_of(:title).is_at_least(10).is_at_most(100) }
  it { should ensure_length_of(:body).is_at_least(50).is_at_most(600) }
end
