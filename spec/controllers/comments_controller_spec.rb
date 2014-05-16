require 'spec_helper'

describe CommentsController do
  describe 'GET #new' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }
    let(:comment) { create(:comment) }

    context 'user is a sign in' do
      login_user
      context 'adds comment to @question' do
        before(:each) { get :new, question_id: question }

        it 'assigns a new Comment to @comment' do
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it 'checks @comment_object stock instance of Question' do
          expect(assigns(:comment_object)).to eq question
        end
        it 'renders view :new' do
          expect(response).to render_template :new
        end
      end

      context 'adds comment to @answer' do
        before(:each) { get :new, answer_id: answer }

        it 'assigns a new Comment to @comment' do
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it 'checks @comment_object stock instance of Answer' do
          expect(assigns(:comment_object)).to eq answer
        end
        it 'renders view :new' do
          expect(response).to render_template :new
        end
      end
    end
    context 'user is a guest' do
      it 'redirects to sign in page' do
        get :new, question_id: question
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    let(:comment) { create(:comment) }

    context 'when user is sign in' do
      login_user
      before(:each) { get :edit, id: comment }
      it 'assigns the requested comment to @comment' do
        expect(assigns(:comment)).to eq comment
      end

      it 'renders view :edit' do
        expect(response).to render_template :edit
      end
    end

    context 'when user is a quest' do
      it 'redirects to sign in page' do
        get :edit, id: comment
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }
    let(:comment) { create(:comment) }

    context 'user is a sign in' do
      login_user
      context 'adds comment to @question' do
        def request(type_data)
          post :create, question_id: question, comment: attributes_for(type_data)
        end

        context 'with valid attributes' do
          it 'saves new comment with attributes' do
            expect { request(:comment) }.to change(Comment, :count).by(1)
          end

          it 'notifies succes creation message' do
            request(:comment)
            expect(flash[:notice]).to eq 'Your comment has been successfully created.'
          end

          it 'saves to collection user.comments' do
            expect { request(:comment) }.to change(@user.comments, :count).by(1)
          end

          it 'saves to collection question.comments' do
            expect { request(:comment) }.to change(question.comments, :count).by(1)
          end
          it 'redirects to show question view' do
            request(:comment)
            expect(response).to redirect_to question_path(assigns(:question))
          end
        end

        context 'with invalid attributes' do
          it 'does not save comment to the database' do
            expect { request(:invalid_comment) }.to_not change(Comment, :count)
          end


          it 'noities fail creation message' do
            request(:invalid_comment)
            expect(flash[:alert]).to eq 'Your comment hasn`t been created. Try again.'
          end

          it 're-renders new view' do
            request(:invalid_comment)
            expect(response).to render_template :new
          end
        end
      end

      context 'adds comment to @answer' do
        def request(type_data)
          post :create, answer_id: answer, comment: attributes_for(type_data)
        end

        context 'with valid attributes' do
          it 'saves new comment with attributes' do
            expect { request(:comment) }.to change(Comment, :count).by(1)
          end

          it 'notifies succes creation message' do
            request(:comment)
            expect(flash[:notice]).to eq 'Your comment has been successfully created.'
          end

          it 'saves to collection user.comments' do
            expect { request(:comment) }.to change(@user.comments, :count).by(1)
          end

          it 'saves to collection question.comments' do
            expect { request(:comment) }.to change(answer.comments, :count).by(1)
          end
          it 'redirects to show question view' do
            request(:comment)
            expect(response).to redirect_to question_path(assigns(:question))
          end
        end

        context 'with invalid attributes' do
          it 'does not save comment to the database' do
            expect { request(:invalid_comment) }.to_not change(Comment, :count)
          end


          it 'noities fail creation message' do
            request(:invalid_comment)
            expect(flash[:alert]).to eq 'Your comment hasn`t been created. Try again.'
          end

          it 're-renders new view' do
            request(:invalid_comment)
            expect(response).to render_template :new
          end
        end
      end
    end


    context 'user is a guest' do
      it 'redirects to sign in page' do
        post :create, question_id: question, comment: attributes_for(:comment)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
