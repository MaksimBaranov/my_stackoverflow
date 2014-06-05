require 'spec_helper'

describe Vote do
  it { should belong_to(:voteable) }
  it { should have_many(:preferences) }
  it { should have_many(:users).through(:preferences) }
  it { should validate_numericality_of(:quantity).only_integer }
end
