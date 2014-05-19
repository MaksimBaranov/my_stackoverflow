require 'spec_helper'

describe VotesController do
  let!(:vote) { create(:vote) }
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer) }

    def add_vote
      question.answers << answer
      vote.question = question
      vote.answer = answer
    end

  describe 'PATCH #up_vote' do
    context 'when user is sign in' do
      login_user

      before(:each) {add_vote}

      it 'assigns the requested vote to @vote' do
        patch :up_vote, id: vote
        expect(assigns(:vote)).to eq vote
      end

      it 'changes vote quantity by 1' do
        old_vote_quantity = vote.quantity
        patch :up_vote, id: vote
        vote.reload
        expect(vote.quantity).to eq(old_vote_quantity + 1)
      end

      it 'redirects to view show question page' do
        patch :up_vote, id: vote
        expect(response).to redirect_to question_path(question)
      end

      it 'renders notice :success' do
        patch :up_vote, id: vote
        expect(flash[:notice]).to eq 'Your voice has been added.'
      end
    end

    context 'when user is a quest' do
      it 'redirect to sign in page' do
        patch :up_vote, id: vote
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #down_vote' do
    context 'when user is sign in' do
      login_user

      before(:each) {add_vote}

      it 'assigns the requested vote to @vote' do
        patch :down_vote, id: vote
        expect(assigns(:vote)).to eq vote
      end

      it 'changes vote quantity by 1' do
        old_vote_quantity = vote.quantity
        patch :down_vote, id: vote
        vote.reload
        expect(vote.quantity).to eq(old_vote_quantity - 1)
      end

      it 'redirects to view show question page' do
        patch :down_vote, id: vote
        expect(response).to redirect_to question_path(question)
      end

      it 'renders notice :success' do
        patch :down_vote, id: vote
        expect(flash[:notice]).to eq 'You have subtracted voice.'
      end
    end

    context 'when user is a quest' do
      it 'redirect to sign in page' do
        patch :down_vote, id: vote
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
