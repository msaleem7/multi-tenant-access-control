class MembershipPolicy < ApplicationPolicy
  def create?
    true
  end

  def manage_role?
    user_is_org_owner?
  end

  def destroy?
    case record.role
    when Memberships::Roles::OWNER
      false
    when Memberships::Roles::ADMIN
      user_is_the_creator? || user_is_org_owner?
    when Memberships::Roles::MEMBER
      user_is_the_creator? || user_is_org_owner_or_admin?
    end
  end

  private

  def user_is_the_creator?
    current_user.id == record.user_id
  end

  def user_is_org_owner?
    current_user.memberships.where(
      organisation_id: record.organisation_id,
      role: Memberships::Roles::OWNER
    ).exists?
  end

  def user_is_org_admin?
    current_user.memberships.where(
      organisation_id: record.organisation_id,
      role: Memberships::Roles::ADMIN
    ).exists?
  end

  def user_is_org_owner_or_admin?
    current_user.memberships.where(
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
