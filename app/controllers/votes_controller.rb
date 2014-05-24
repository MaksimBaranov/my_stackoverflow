class VotesController < ApplicationController
  before_filter :authenticate_user!

  def up
    @vote = Vote.find(params[:id])
    current_quantity_vote = @vote.quantity
    if @vote.update_attributes(quantity: current_quantity_vote + 1)
      redirect_to  @vote.question, notice: 'Your voice has been added.'
    else
      redirect_to  @vote.question, alert: 'Try Again.'
    end
  end

  def down
    @vote = Vote.find(params[:id])
    current_quantity_vote = @vote.quantity
    if @vote.update_attributes(quantity: current_quantity_vote - 1)
      redirect_to  @vote.question, notice: 'You have subtracted voice.'
    else
      redirect_to  @vote.question, alert: 'Try Again.'
    end
  end

  # TODO - rewrite name of actions to up and down
end
