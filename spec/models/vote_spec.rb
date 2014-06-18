require 'spec_helper'

describe Vote do
  it { should belong_to(:voteable) }
  it { should belong_to(:user) }
  it { should ensure_inclusion_of(:value).in_array([-1, 1]) }



  describe '#voting' do
    let!(:vote) { create(:vote) }
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer) }

    context 'Question' do
      it "create new vote record if User didn`t vote for it " do
        vote.voting(user, question, 1)
        expect(vote[:user_id]).to eq user.id
        expect(vote[:voteable_id]).to eq question.id
        expect(vote[:voteable_type]).to eq 'Question'
        expect(vote[:value]).to eq 1
      end

      it "destroy users record if voting value not  equal record value" do
        vote1 =create(:vote, value: 1)
        question.votes << vote1
        user.votes << vote1

        expect{ vote1.voting(user, question, -1) }.to  change(Vote, :count).by(-1)
      end
    end

    context 'Answer' do
      it "create new vote record if User didn`t vote for it " do
        vote.voting(user, answer, -1)
        expect(vote[:user_id]).to eq user.id
        expect(vote[:voteable_id]).to eq answer.id
        expect(vote[:voteable_type]).to eq 'Answer'
        expect(vote[:value]).to eq -1
      end

      it "destroy users record if voting value not  equal record value" do
        vote1 =create(:vote, value: -1)
        answer.votes<< vote1
        user.votes << vote1

        expect{ vote1.voting(user, answer, 1) }.to  change(Vote, :count).by(-1)
      end
    end
  end
end
