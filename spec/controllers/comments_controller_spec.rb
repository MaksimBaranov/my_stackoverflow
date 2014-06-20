require 'spec_helper'

describe CommentsController do
  # describe 'GET #new' do
  #   let(:question) { create(:question) }
  #   let(:answer) { create(:answer) }
  #   let(:comment) { create(:comment) }

  #   context 'user is a sign in' do
  #     login_user
  #     context 'adds comment to @question' do
  #       before(:each) { get :new, question_id: question }

  #       it 'assigns a new Comment to @comment' do
  #         expect(assigns(:comment)).to be_a_new(Comment)
  #       end

  #       it 'checks @comment_object stock instance of Question' do
  #         expect(assigns(:comment_object)).to eq question
  #       end
  #       it 'renders view :new' do
  #         expect(response).to render_template :new
  #       end
  #     end

  #     context 'adds comment to @answer' do
  #       before(:each) { get :new, answer_id: answer }

  #       it 'assigns a new Comment to @comment' do
  #         expect(assigns(:comment)).to be_a_new(Comment)
  #       end

  #       it 'checks @comment_object stock instance of Answer' do
  #         expect(assigns(:comment_object)).to eq answer
  #       end
  #       it 'renders view :new' do
  #         expect(response).to render_template :new
  #       end
  #     end
  #   end
  #   context 'user is a guest' do
  #     it 'redirects to sign in page' do
  #       get :new, question_id: question
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end

  # describe 'GET #edit' do
  #   let(:comment) { create(:comment) }

  #   context 'when user is sign in' do
  #     login_user
  #     before(:each) { get :edit, id: comment }
  #     it 'assigns the requested comment to @comment' do
  #       expect(assigns(:comment)).to eq comment
  #     end

  #     it 'renders view :edit' do
  #       expect(response).to render_template :edit
  #     end
  #   end

  #   context 'when user is a quest' do
  #     it 'redirects to sign in page' do
  #       get :edit, id: comment
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end

  describe 'POST #create' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }
    let(:comment) { create(:comment) }

    context 'user is a sign in' do
      login_user
      context 'adds comment to @question' do
        def request(type_data)
          post :create, question_id: question, comment: attributes_for(type_data), format: :js
        end

        context 'with valid attributes' do
          it 'saves new comment with attributes' do
            expect { request(:comment) }.to change(Comment, :count).by(1)
          end

          it 'saves to collection user.comments' do
            expect { request(:comment) }.to change(@user.comments, :count).by(1)
          end

          it 'saves to collection question.comments' do
            expect { request(:comment) }.to change(question.comments, :count).by(1)
          end
          it 'renders create.js' do
            request(:comment)
            expect(response).to render_template :create
          end
        end

        context 'with invalid attributes' do
          it 'does not save comment to the database' do
            expect { request(:invalid_comment) }.to_not change(Comment, :count)
          end
        end
      end

      context 'adds comment to @answer' do
        def request(type_data)
          post :create, answer_id: answer, comment: attributes_for(type_data), format: :js
        end

        context 'with valid attributes' do
          it 'saves new comment with attributes' do
            expect { request(:comment) }.to change(Comment, :count).by(1)
          end

          it 'saves to collection user.comments' do
            expect { request(:comment) }.to change(@user.comments, :count).by(1)
          end

          it 'saves to collection question.comments' do
            expect { request(:comment) }.to change(answer.comments, :count).by(1)
          end

          it 'renders create.js' do
            request(:comment)
            expect(response).to render_template :create
          end
        end

        context 'with invalid attributes' do
          it 'does not save comment to the database' do
            expect { request(:invalid_comment) }.to_not change(Comment, :count)
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

  describe 'PATCH #update' do
    let(:comment) { create(:comment) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }

    def add_comment_to_question
      comment.commentable = question
      comment.save
    end

    def add_comment_to_answer
      question.answers << answer
      question.save
      comment.commentable = answer
      comment.save
    end

    context 'when user is a sign in' do
      login_user

      context 'when comments question' do
        before(:each) { add_comment_to_question }

        context 'with valid attributes' do
          it 'assigns the requested comment to @comment' do
            patch :update, id: comment, comment: { text: "some comment"*5 }
            expect(assigns(:comment)).to eq comment
          end

          it 'changes comment attributes' do
            @user.comments << comment
            patch :update, id: comment, comment: { text: "some comment"*5 }
            comment.reload
            expect(comment.text).to eq "some comment"*5
         end

          it 'renders to view QuestionController#show' do
            @user.comments << comment
            patch :update, id: comment, comment: { text: "some comment"*5 }, format: :js
            expect(response).to render_template :update
          end
        end

        context 'with invalid attributes' do
          it 'does not change comment attributes' do
            patch :update, id: comment, comment: { text: "some text" }
            answer.reload
            expect(answer.text).to eq answer.text
          end

          it 're-renders edit view' do
           @user.comments << comment
            patch :update, id: comment, comment: { text: "some text" }
            expect(response).to render_template :edit
          end
        end
      end

      context 'when comments answer' do
        before(:each) { add_comment_to_answer }

        context 'with valid attributes' do
          it 'assigns the requested comment to @comment' do
            patch :update, id: comment, comment: { text: "some comment"*5 }
            expect(assigns(:comment)).to eq comment
          end

          it 'changes comment attributes' do
            @user.comments << comment
            patch :update, id: comment, comment: { text: "some comment"*5 }
            comment.reload
            expect(comment.text).to eq "some comment"*5
         end

          it 'renders to view QuestionController#show' do
           @user.comments << comment
            patch :update, id: comment, comment: { text: "some comment"*5 }, format: :js
            expect(response).to render_template :update
          end
        end

        context 'with invalid attributes' do
          it 'does not change comment attributes' do
           @user.comments << comment
            patch :update, id: comment, comment: { text: "some text" }
            answer.reload
            expect(answer.text).to eq answer.text
          end

          it 're-renders edit view' do
           @user.comments << comment
            patch :update, id: comment, comment: { text: "some text" }
            expect(response).to render_template :edit
          end
        end
      end
    end

    context 'when user is a quest' do
      it 'redirects to sign in page' do
        patch :update, id: comment, comment: attributes_for(:comment)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:comment) { create(:comment) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }

    def add_comment_to_question
      comment.commentable = question
      comment.save
    end

    def add_comment_to_answer
      question.answers << answer
      question.save
      comment.commentable = answer
      comment.save
    end

    context 'user is sign in' do
      login_user

      context 'deletes comment of question' do
        before(:each) do
          add_comment_to_question
         @user.comments << comment
        end

        it 'deletes commetn' do
          comment
          expect { delete :destroy, id: comment }.to change(Comment, :count).by(-1)
        end

        it 'renders destroy template' do
          delete :destroy, id: comment, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'deletes comment of answer' do
        before(:each) do
          @user.comments << comment
          add_comment_to_answer
        end

        it 'deletes comment' do
          comment
          expect { delete :destroy, id: comment }.to change(Comment, :count).by(-1)
        end

        it 'renders destroy template' do
          delete :destroy, id: comment, format: :js
          expect(response).to render_template :destroy
        end
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
