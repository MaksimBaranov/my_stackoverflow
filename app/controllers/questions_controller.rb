class QuestionsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :delete]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
  end
end
