class SpacePolicy < ApplicationPolicy
  def show?
    user_is_space_member? || user_is_org_owner_or_admin?
  end

  def create?
    user_is_org_owner_or_admin?
  end

  def update?
    user_is_org_owner_or_admin?
  end

  def destroy?
    user_is_org_owner_or_admin?
  end

  private

  def user_is_space_member?
    user.spaces.ids.include?(record.id)
  end

  def user_is_org_owner_or_admin?
    @user_is_org_owner_or_admin ||= user.memberships.where(
      organisation_id: record.organisation_id,
      role: [Memberships::Roles::ADMIN, Memberships::Roles::OWNER]
    ).exists?
  end

  class Scope < BaseScope
    def resolve
      scope
    end
  end
end
