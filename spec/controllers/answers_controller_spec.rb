require 'spec_helper'

describe AnswersController do
  describe 'POST #create' do
    let(:question) { create(:question) }

    def request(type_data)
      post :create, question_id: question, answer: attributes_for(type_data)
    end

    context 'user is sign in' do
      login_user
      context 'with valid attributes' do
        it 'saves the new answer in the database' do
          expect { request(:answer) }.to change(Answer, :count).by(1)
        end

        it 'redirects to show view of current question' do
          request(:answer)
          expect(response).to redirect_to question_path(assigns(:question))
        end

        it 'saves new answer with attribute user_id' do
          expect { request(:answer) }.to change(@user.answers, :count)
        end

        it 'saves new answer with attribute question_id' do
          expect { request(:answer) }.to change(question.answers, :count)
        end

        it 'renders flash message about success creation' do
          request(:answer)
          expect(flash[:notice]).to eq 'Your answer was successfully created.'
        end
      end

      context 'with invalid attributes' do
        it 'does not save answer to database' do
          expect { request(:invalid_answer) }.to_not change(Answer, :count)
        end

        it 'redirectes to view show of current question' do
          request(:invalid_answer)
          expect(response).to redirect_to question_path(question)
        end

        it 'renders flash message about fail creation' do
          request(:invalid_answer)
          expect(flash[:alert]).to eq 'Your answer wasn`t created. Try again.'
        end
      end
    end

    context 'user is a quest' do
      it 'redirect to sign in page' do
        request(:answer)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }

    context 'user is sign in' do
      login_user
      before(:each) { get :edit, question_id: question, id: answer }

      it 'assigns the requested answer to @answer' do
        expect(assigns(:answer)).to eq answer
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'user is a quest' do
      it 'redirect to sign in page' do
        get :edit, question_id: question, id: answer
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
  end
end
