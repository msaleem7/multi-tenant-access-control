class RemoveUniqueConstraintFromPosts < ActiveRecord::Migration[8.0]
  def change
    # Remove the unique constraint from posts table
    remove_index :posts, name: "index_posts_on_user_id_and_space_id"
    
    # Re-add the index without the unique constraint
    add_index :posts, [:user_id, :space_id]
  end
end
