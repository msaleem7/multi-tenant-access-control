# frozen_string_literal: true

class CreateUserSpaces < ActiveRecord::Migration[8.0]
  def change
    create_table :user_spaces do |t|
      t.references :user, null: false, foreign_key: true
      t.references :space, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_spaces, [:user_id, :space_id], unique: true
  end
end
