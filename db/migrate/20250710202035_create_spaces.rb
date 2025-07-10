# frozen_string_literal: true

class CreateSpaces < ActiveRecord::Migration[8.0]
  def change
    create_table :spaces do |t|
      t.string     :name, null: false
      t.text       :description
      t.references :organisation, null: false, foreign_key: true
      t.integer    :min_age
      t.integer    :max_age
      t.boolean    :requires_parental_consent, default: false

      t.timestamps
    end

    add_index :spaces, [:organisation_id, :name], unique: true
  end
end
