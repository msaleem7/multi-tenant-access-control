class AddUniqueConstraintOnOrganisationOwnership < ActiveRecord::Migration[8.0]
  def change
    # This ensures there is only one membership with
    # role = 0 (i.e., owner) per organisation at the DB level.
    add_index :memberships,
              [:organisation_id],
              unique: true,
              where: "role = 0",
              name: "unique_owner_per_organization"
  end
end
