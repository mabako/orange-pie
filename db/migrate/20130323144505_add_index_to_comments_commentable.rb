class AddIndexToCommentsCommentable < ActiveRecord::Migration
  def change
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
