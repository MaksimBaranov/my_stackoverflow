class AddVoteIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :vote_id, :integer
  end
end
