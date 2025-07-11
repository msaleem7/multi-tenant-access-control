class OrganisationPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    user_is_org_owner?
  end

  private

  def user_is_org_owner?
    current_user.memberships.where(
      organisation_id: record.id,
      role: Memberships::Roles::OWNER
    ).exists?
  end

  class Scope < BaseScope
    def resolve
      scope.where(id: current_user.memberships.pluck(:organisation_id))
    end
  end
end
