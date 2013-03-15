class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.text :text
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
    add_index :comments, :user_id
  end
end
