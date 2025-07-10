# frozen_string_literal: true

class CreateOrganisations < ActiveRecord::Migration[8.0]
  def change
    create_table :organisations do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :organisations, :name
  end
end
