class AddAncestryToForums < ActiveRecord::Migration
  def change
    add_column :forums, :ancestry, :string
    add_index :forums, :ancestry
  end
end
