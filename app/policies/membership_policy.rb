class MembershipPolicy < ApplicationPolicy
  def create?
    user_is_org_owner? || user_is_org_admin?
  end

  def destroy?
    # Can't remove owners
    return false if record.role == Memberships::Roles::OWNER
    
    # Only owners and admins can remove members
    user_is_org_owner? || user_is_org_admin?
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

  class Scope < BaseScope
    def resolve
      scope
    end
  end
end
