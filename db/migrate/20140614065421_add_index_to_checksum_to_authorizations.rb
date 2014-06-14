class AddIndexToChecksumToAuthorizations < ActiveRecord::Migration
  def change
    add_index :authorizations, :checksum
  end
end
