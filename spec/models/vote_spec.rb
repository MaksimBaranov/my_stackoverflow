require 'spec_helper'

describe Vote do
  it { should have_one(:question) }
  it { should have_one(:answer) }
  it { should validate_numericality_of(:quantity).only_integer }
end
