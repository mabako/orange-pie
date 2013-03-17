class AddSortToForums < ActiveRecord::Migration
  def change
    add_column :forums, :sort, :integer, :default => 1, :null => false
  end
end
