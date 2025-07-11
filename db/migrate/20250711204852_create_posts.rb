class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :age_rating, default: 0

      t.references :user, null: false, foreign_key: true
      t.references :space, null: false, foreign_key: true
      t.timestamps
    end
    
    add_index :posts, [:user_id, :space_id], unique: true
  end
end
