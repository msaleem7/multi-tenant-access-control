class MembershipPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    case record.role
    when Memberships::Roles::OWNER
      user_is_org_owner?
    when Memberships::Roles::ADMIN
      user_is_org_owner? || user_is_org_admin?
    when Memberships::Roles::MEMBER
      user_is_org_owner? || user_is_org_admin? || user_is_the_creator?
    end
  end

  private

  def user_is_the_creator?
    user.id == record.user_id
  end

  def user_is_org_owner?
    user.memberships.where(
      organisation_id: record.organisation_id,
      role: Memberships::Roles::OWNER
    ).exists?
  end

  def user_is_org_admin?
    user.memberships.where(
      organisation_id: record.organisation_id,
      role: Memberships::Roles::ADMIN
    ).exists?
  end

  class Scope < BaseScope
    def resolve
      scope
    end
  end
end
