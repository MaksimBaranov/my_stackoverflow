require 'spec_helper'

describe AnswersController do
  describe 'POST #create' do
    let(:question) { create(:question) }

    context 'user is sign in' do
      login_user
      context 'with valid attributes' do
        it 'saves the new answer in the database' do
          expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(Answer, :count).by(1)
        end

        it 'redirects to show view of current question' do
          post :create, question_id: question, answer:attributes_for(:answer)
          expect(response).to redirect_to question_path(assigns(:question))
        end

        it 'saves new answer with attribute user_id' do
          expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(@user.answers, :count)
        end

        it 'saves new answer with attribute question_id' do
          expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count)
        end
      end
    end

    context 'user is a quest' do
      it 'redirect to sign in page' do
        post :create, question_id: question
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
