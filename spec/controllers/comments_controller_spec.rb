require 'spec_helper'

describe CommentsController do
  describe 'GET #new' do
    let(:question) { create(:question) }
    let(:comment) { create(:comment) }

    context 'user is a sign in' do
      login_user
      it 'assigns a new Comment to @comment' do
        get :new, question_id: question
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it 'checks @question' do
        get :new, question_id: question
        expect(assigns(:question)).to eq question
      end
      it 'renders view :new' do
        get :new, question_id: question
        expect(response).to render_template :new
      end
    end
    context 'user is a guest' do
      it 'redirects to sign in page' do
        get :new, question_id: question
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do

  end
end
