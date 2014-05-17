class AddVoteIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :vote_id, :integer
  end
end
