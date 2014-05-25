class VotesController < ApplicationController
  before_filter :authenticate_user!

  def up
    @vote = Vote.find(params[:id])
    if @vote.update_attributes(quantity: @vote.add_vote)
      redirect_to  @vote.question, notice: 'Your voice has been added.'
    else
      redirect_to  @vote.question, alert: 'Try Again.'
    end
  end

  def down
    @vote = Vote.find(params[:id])
    if @vote.update_attributes(quantity: @vote.down_vote)
      redirect_to  @vote.question, notice: 'You have subtracted voice.'
    else
      redirect_to  @vote.question, alert: 'Try Again.'
    end
  end
end
