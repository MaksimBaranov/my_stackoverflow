require 'spec_helper'

describe Preference do
  it { should belong_to(:user) }
  it { should belong_to(:vote) }
end
