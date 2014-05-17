require 'spec_helper'

describe Vote do
  it { should belong_to(:voteable) }
  it { should validate_numericality_of(:quantity).only_integer }
end
