require 'spec_helper'

describe Tag do
  it { should have_many(:taggings) }
  it { should have_many(:questions).through(:taggings) }
end
