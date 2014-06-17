class CreateReputationConstants < ActiveRecord::Migration
  def change
    create_table :reputation_constants do |t|
      t.integer :value
      t.string :code

      t.timestamps
    end
  end
end
