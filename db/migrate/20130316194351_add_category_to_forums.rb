class AddCategoryToForums < ActiveRecord::Migration
  def change
    add_column :forums, :category, :boolean
  end
end
