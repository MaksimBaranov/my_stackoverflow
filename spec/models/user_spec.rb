require 'spec_helper'

describe User do
  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }
  it { should have_many(:preferences) }
  it { should have_many(:votes).through(:preferences) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
end
