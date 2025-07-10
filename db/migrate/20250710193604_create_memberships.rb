# frozen_string_literal: true

class CreateMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organisation, null: false, foreign_key: true
      t.integer    :role, default: 0, null: false
      t.timestamps
    end

    add_index :memberships, [:organisation_id, :role]
    add_index :memberships, [:user_id, :organisation_id], unique: true
  end
end
