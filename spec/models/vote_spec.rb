require 'spec_helper'

describe Vote do
  it { should belong_to(:voteable) }
  it { should validate_numericality_of(:quantity).only_integer }

  let(:vote) { create(:vote) }
  it 'should add one vote' do
    new_quantity = vote.quantity + 1
    expect(assigns(:vote)).to eq vote.quantity + 1
  end
end
