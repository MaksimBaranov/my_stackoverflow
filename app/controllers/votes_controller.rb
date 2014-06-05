class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_vote

  def up
    respond_to do |format|
      if @vote.vote_up(current_user, 1)
        format.html { redirect_to  @vote.question, notice: 'Your voice has been added.' }
        format.js
      else
        format.html { redirect_to  @vote.question, alert: 'Try Again.' }
        format.js
      end
    end
  end

  def down
    respond_to do |format|
      if @vote.vote_down(current_user, -1)
        format.html { redirect_to  @vote.question, notice: 'You have subtracted voice.' }
        format.js
      else
        format.html { redirect_to  @vote.question, alert: 'Try Again.' }
        format.js
      end
    end
  end

  private

  def load_vote
    @vote = Vote.find(params[:id])
  end
end
