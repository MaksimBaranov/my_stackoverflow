require 'spec_helper'

describe Answer do
  it { should belong_to(:user) }
  it { should belong_to(:question), counter_cache: true }
  it { should have_many(:vote) }
  it { should have_many(:favorites) }
  it { should have_many :attachments }
  it { should have_many(:comments) }

  it { should validate_presence_of :text }
  it { should ensure_length_of(:text).is_at_least(10).is_at_most(600) }

  it { should accept_nested_attributes_for :attachments }

  let!(:user) { create(:user) }
  let!(:user1){ create(:user) }
  let!(:question){ create(:question) }
  let!(:answer){ create(:answer, user: user1) }

  # context ".after create" do
  #   it "add point to user's reputation" do
  #     user.questions << question
  #     question.answers << answer
  #     old_reputation = user1.reputation
  #     expect(user1.reputation).to eq old_reputation + 1
  #   end
  # end
end
