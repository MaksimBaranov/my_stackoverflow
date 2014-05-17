require 'spec_helper'

describe VotesController do
  describe 'PATCH #up_vote' do
    context 'when user is sign in' do
      login_user

      let(:question) { create(:question) }
      let(:vote) { create(:vote) }

      it 'assigns the requested vote to @vote' do
        patch :up_vote, id: vote
        expect(assigns(:vote)).to eq vote
      end

      it 'changes vote quantity by 1' do
        patch :up_vote, id: vote
        vote.reload
        expect(vote.quantity).to eq vote.quantity + 1
      end

      it 'redirects to view show question page' do
        patch up_vote, id: vote
        expect(response).to redirect_to question
      end

      it 'renders notice :success' do
        patch :up_vote, id: vote
        expect(flash[:notice]).to eq 'Your voice has been added'
      end
    end

    context 'when user is a quest' do
      it 'redirect to sign in page' do
        patch :up_vote, id: vote
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
