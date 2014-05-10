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

        it 'renders flash message about success creation' do
          post :create, question_id: question, answer: attributes_for(:answer)
          expect(flash[:notice]).to eq 'Your answer was successfully created.'
        end
      end

      context 'with invalid attributes' do
        it 'does not save answer to database' do
          expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
        end

        it 'redirectes to view show of current question' do
          post :create, question_id: question, answer: attributes_for(:invalid_answer)
          expect(response).to redirect_to question_path(question)
        end

        it 'renders flash message about fail creation' do
          post :create, question_id: question, answer: attributes_for(:invalid_answer)
          expect(flash[:alert]).to eq 'Your answer wasn`t created. Try again.'
        end
      end
    end

    context 'user is a quest' do
      it 'redirect to sign in page' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
