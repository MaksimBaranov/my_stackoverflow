class AddConfirmedToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :confirmed, :boolean, default: false
  end
end
