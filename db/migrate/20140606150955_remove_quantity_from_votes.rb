class RemoveQuantityFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :quantity
  end
end
