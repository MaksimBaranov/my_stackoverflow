--class VotesController < ApplicationController
  before_filter :authenticate_user!

  def up
    @vote = Vote.find(params[:id])
    respond_to do |format|
      if @vote.update_attributes(quantity: @vote.add_vote)
        format.html { redirect_to  @vote.question, notice: 'Your voice has been added.' }
        format.js
      else
        format.html { redirect_to  @vote.question, alert: 'Try Again.' }
        format.js
      end
    end
  end

  def down
    @vote = Vote.find(params[:id])
    respond_to do |format|
      if @vote.update_attributes(quantity: @vote.down_vote)
        format.html { redirect_to  @vote.question, notice: 'You have subtracted voice.' }
        format.js
      else
        format.html { redirect_to  @vote.question, alert: 'Try Again.' }
        format.js
      end
    end
  end
end
