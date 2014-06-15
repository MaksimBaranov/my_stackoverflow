require 'spec_helper'

describe Favorite do
  it { should belong_to(:favoriteable) }
  it { should belong_to(:user) }
end
