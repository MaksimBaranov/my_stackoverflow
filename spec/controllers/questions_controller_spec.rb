require 'spec_helper'

describe QuestionsController do

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'fill in an array of all questions'  do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do

    context 'user is sign in' do
      login_user
      before(:each) do
        xhr :get, :new, format: :js
      end

      it 'assigns a new Question to @question'  do
        expect(assigns(:question)).to be_a_new(Question)
      end

      # it 'builds new attachment for question' do
      #   expect(assigns(:question).attachments.first).to be_a_new(Attachment)
      # end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'user is a quest' do
      it 'redirect to sign in page' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    shared_examples 'checks @question and renders template show' do
      let(:question) { create(:question) }
      before(:each) { get :show, id: question }

      it 'checks @question' do
        expect(assigns(:question)).to eq question
      end

      it 'renders template new' do
        expect(response).to render_template :show
      end
    end

    context 'user is a quest' do
      it_should_behave_like 'checks @question and renders template show'
    end

    context 'user is sign in' do
      login_user
      it_should_behave_like 'checks @question and renders template show'
    end
  end

  describe 'GET #edit' do
    let(:question) { create(:question) }

    context 'user is sign in' do
      login_user

      before(:each) do
        @user.questions << question
        xhr :get, :edit, id: question, format: :js
      end

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'user is a quest' do
      before { get :edit, id: question }

      it 'redirect to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'user is sign in' do
      login_user

      def request(type_data)
        post :create, question: attributes_for(type_data), format: :js
      end

      context 'with valid attributes' do
        it 'saves the new question in the database' do
          expect { request(:question) }.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          request(:question)
          expect(response).to render_template :create
        end

        it 'saves the new question with attribute user_id' do
          expect { request(:question) }.to change(@user.questions, :count)
        end
      end

      context 'with invalid attributes' do
        it 'does not save question to the database' do
          expect { request(:invalid_question) }.to_not change(Question, :count)
        end
        it 're-renders new view' do
          request(:invalid_question)
          expect(response).to render_template :create
        end
      end
    end

    context 'user is a guest' do
      it 'redirect to sign in page' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:question) { create(:question) }

    context 'user is sign in' do
      login_user

      context 'with valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, id: question, question: attributes_for(:question), format: :js
          expect(assigns(:question)).to eq question
        end

        it 'changes question attributes' do
          @user.questions << question
          patch :update, id: question, question: { title: 'new title edit now.', body: 'edit body'*10, tag_names: 'Rails, Ruby' }
          question.reload
          expect(question.title).to eq 'new title edit now.'
          expect(question.body).to eq 'edit body'*10
          expect(question.tags.map(&:name)).to eq ['Rails','Ruby']
        end

        it 'renders update.js.erb' do
          @user.questions << question
          patch :update, id: question, question: attributes_for(:question), format: :js
          expect(response).to render_template :update
        end
      end

      context 'with invalid attributes' do
        before do
          @user.questions << question
          patch :update, id: question, question: { title: 'new title edit at now.', body: nil }, format: :js
        end

        it 'does not change question attributes' do
          question.reload
          expect(question.title).to eq question.title
          expect(question.body).to eq question.body
        end

        it 're-renders edit view' do
          expect(response).to render_template :update
        end
      end
    end

    context 'user is a quest' do
      it 'redirect to sign in page' do
         patch :update, id: question, question: { title: 'new title edit now.', body: 'edit body'*10 }
         expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do

    let(:question) { create(:question) }

    context 'user is sign in' do
      login_user

      it 'deletes question' do
        question
       @user.questions << question
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end
      it 'redirect to index view' do
        @user.questions << question
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'user is a quest' do
      it 'redirects to sign in page' do
        delete :destroy, id: question
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
