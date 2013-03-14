class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :integer, :null => false, :default => 0
  end
end
