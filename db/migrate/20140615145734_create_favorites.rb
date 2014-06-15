class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :favoriteable_id
      t.string :favoriteable_type

      t.timestamps
    end
  end
end
