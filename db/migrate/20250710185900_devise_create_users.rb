# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string    :email, null: false, default: ""
      t.string    :encrypted_password, null: false, default: ""
      t.string    :reset_password_token
      t.datetime  :reset_password_sent_at

      t.string    :first_name, null: false
      t.string    :last_name, null: false
      t.boolean   :parental_consent, default: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
