class AddChecksumToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :checksum, :string
  end
end
