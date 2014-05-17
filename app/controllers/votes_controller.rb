class VotesController < ApplicationController
  before_filter :authenticate_user!

  def up_vote
    @vote = Vote.find(params[:id])
    current_quantity_vote = @vote.quantity
    if @vote.update_attributes(quantity: current_quantity_vote + 1)
      redirect_to :back, notice: 'Your voice has been added'
    else
      redirect_to :back , alert: 'Try Again.'
    end
  end

  def down_vote

  end

end
