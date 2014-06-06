require 'spec_helper'

describe Vote do
  it { should belong_to(:voteable) }
  it { should belong_to(:user) }

  let!(:vote) { create(:vote) }
  let!(:user) { create(:user) }

  context '#voting' do

    it 'add vote to users' do
      vote.voting(user)
    end

    it 'add vote to question'

    it 'add vote to answer'

    it 'check like  status'
  end
end
