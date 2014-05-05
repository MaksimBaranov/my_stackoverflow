require 'spec_helper'

describe QuestionsController do

  describe "GET #index" do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'fill in an array of all questions'  do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do

    context "user is sign in" do
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

    context "user is a quest" do
      it "redirect to sign in page" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #show" do
    shared_examples "checks @question and renders template new" do
      let(:question) { create(:question) }
      before(:each) {get :show, id: question}

      it "checks @question" do
        expect(assigns(:question)).to eq question
      end

      it "renders template new" do
        expect(response).to render_template :show
      end
    end

    context "user is a quest" do
      it_should_behave_like "checks @question and renders template new"
    end

    context "user is sign in"do
      login_user
      it_should_behave_like "checks @question and renders template new"
    end
  end
end
