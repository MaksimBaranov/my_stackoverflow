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
        get :new
      end

      it 'assigns a new Question to @question'  do
        expect(assigns(:question)).to be_a_new(Question)
      end

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

  describe 'POST #create' do
    context 'user is sign in' do
      login_user

      def request(type_data)
        post :create, question: attributes_for(type_data)
      end

      context 'with valid attributes' do
        it 'saves the new question in the database' do
          expect { request(:question) }.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          request(:question)
          expect(response).to redirect_to question_path(assigns(:question))
        end

        it 'saves the new question withattribute user_id' do
          expect { request(:question) }.to change(@user.questions, :count)
        end
      end

      context 'with invalid attributes' do
        it 'does not save question to the database' do
          expect { request(:invalid_question) }.to_not change(Question, :count)
        end
        it 're-renders new view' do
          request(:invalid_question)
          expect(response).to render_template :new
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
end
