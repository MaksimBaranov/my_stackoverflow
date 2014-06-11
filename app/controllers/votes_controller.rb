class VotesController < InheritedResources::Base
  respond_to :js
  before_filter :authenticate_user!
  before_filter :build_vote, only: [:up, :down]
  belongs_to :answer, :question, polymorphic: true

  def up
    @vote.voting(current_user, parent, 1 )
  end

  def down
    @vote.voting(current_user, parent, -1 )
  end

  protected

  def build_vote
    @vote = Vote.new
  end
end
