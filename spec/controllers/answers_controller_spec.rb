require 'spec_helper'

describe AnswersController do
  describe 'POST #create' do
    let(:question) { create(:question) }

    def request(type_data)
      post :create, question_id: question, answer: attributes_for(type_data), format: :js
    end

    context 'user is sign in' do
      login_user
      context 'with valid attributes' do
        it 'saves the new answer in the database' do
          expect { request(:answer) }.to change(Answer, :count).by(1)
        end

        it 'redirects to show view of current question' do
          request(:answer)
          expect(response).to render_template :create
        end

        it 'saves new answer with attribute user_id' do
          expect { request(:answer) }.to change(@user.answers, :count)
        end

        it 'saves new answer with attribute question_id' do
          expect { request(:answer) }.to change(question.answers, :count)
        end

        # it 'renders flash message about success creation' do
        #   request(:answer)
        #   expect(flash[:notice]).to eq 'Your answer has been successfully created.'
        # end
      end

      context 'with invalid attributes' do
        it 'does not save answer to database' do
          expect { request(:invalid_answer) }.to_not change(Answer, :count)
        end

        it 'redirectes to view show of current question' do
          request(:invalid_answer)
          expect(response).to  render_template :create
        end

        # it 'renders flash message about fail creation' do
        #   request(:invalid_answer)
        #   expect(flash[:alert]).to eq 'Your answer hasn`t been created. Try again.'
        # end
      end
    end

    context 'user is a quest' do
      it 'redirect to sign in page' do
        post :create, question_id: question, answer: attributes_for(:answer)
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
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }

    context 'user is sign in' do
      login_user

      context 'with valid attributes' do
        it 'assigns the requested answer to @answer' do
          patch :update, question_id: question, id: answer, answer: attributes_for(:answer)
          expect(assigns(:answer)).to eq answer
        end

        it 'changes answer attributes' do
          patch :update, question_id: question, id: answer, answer: { text: "some text"*10 }
          answer.reload
          expect(answer.text).to eq "some text"*10
        end

        it 'redirects to view show question page' do
          patch :update, question_id: question, id: answer, answer: attributes_for(:answer)
          expect(response).to redirect_to question
        end

         it 'renders flash message about success updating' do
          patch :update, question_id: question, id: answer, answer: { text: "some text"*10 }
          expect(flash[:notice]).to eq 'Answer has been successfully updated.'
        end
      end

      context 'with invalid attributes' do

        it 'does not change answer attributes' do
          patch :update, question_id: question, id: answer, answer: { text: "some text" }
          answer.reload
          expect(answer.text).to eq answer.text
        end

        it 're-renders edit view' do
          patch :update, question_id: question, id: answer, answer: { text: "some text" }
          expect(response).to render_template :edit
        end

        it 'renders flash message about fail updating' do
          patch :update, question_id: question, id: answer, answer: { text: "some text" }
          expect(flash[:alert]).to eq 'Answer hasn`t been updated. Try again.'
        end
      end
    end

    context 'user is a quest' do
      it 'redirect to sign in page' do
        patch :update, question_id: question, id: answer
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do

    let(:question) { create(:question) }
    let(:answer) { create(:answer) }

    context 'user is sign in' do
      login_user

      it 'deletes answer' do
        answer
        expect { delete :destroy, question_id: question, id: answer }.to change(Answer, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, question_id: question, id: answer
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'user is a quest' do
      it 'redirects to sign in page' do
        delete :destroy, question_id: question, id: answer
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
