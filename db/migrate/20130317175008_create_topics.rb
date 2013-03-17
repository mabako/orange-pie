class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.references :user
      t.references :forum
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
    add_index :topics, :user_id
    add_index :topics, :forum_id
  end
end
