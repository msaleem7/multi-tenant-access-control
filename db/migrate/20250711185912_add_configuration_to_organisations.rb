class AddConfigurationToOrganisations < ActiveRecord::Migration[8.0]
  def change
    add_column :organisations, :configuration, :jsonb, default: {}
  end
end
