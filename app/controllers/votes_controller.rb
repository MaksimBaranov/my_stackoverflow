class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_vote
  before_filter :set_vote_object

  def up
    respond_to do |format|
      if @vote.voting(current_user, @vote_object, 1 )
        # format.html { redirect_to  @vote.question, notice: 'Your voice has been added.' }
        format.js
      else
        # format.html { redirect_to  @vote.question, alert: 'Try Again.' }
        format.js {
          flash[:warning] = 'You have been voted already!'
        }
      end
    end
  end

  def down
    respond_to do |format|
      if @vote.voting(current_user, @vote_object, -1 )
        # format.html { redirect_to  @vote.question, notice: 'You have subtracted voice.' }
        format.js
      else
        # format.html { redirect_to  @vote.question, alert: 'Try Again.' }
        format.js {
          flash[:warning] = 'You have been voted already!'
        }
      end
    end
  end

  private

  def load_vote
    @vote = Vote.new
  end


  def set_vote_object
    parent = %w(questions answers).find {|p| request.path.split('/').include? p }[0..-2]
    @vote_object = parent.classify.constantize.find(params["#{parent}_id"])
  end
end
