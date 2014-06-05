class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.integer :vote_id

      t.timestamps
    end

    add_index :preferences, [:user_id, :vote_id]
  end
end
