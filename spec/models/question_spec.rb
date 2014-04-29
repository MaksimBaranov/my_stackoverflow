require 'spec_helper'

describe Question do
  it { should validate_presence_of :title}
  it { should validate_presence_of :body}
  it { should ensure_length_of(:title).is_at_most(50)}
  it { should ensure_length_of(:body).is_at_most(150)}
end
