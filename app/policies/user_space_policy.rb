class UserSpacePolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    user_is_org_owner? || admin_can_destroy? || record_belongs_to_user?
  end

  private

  def admin_can_destroy?
    user_is_admin? && (record_belongs_to_user? || record_user_membership_role == Memberships::Roles::MEMBER)
  end

  def record_user_membership_role
    current_user.memberships.find_by(
      organisation_id: organisation.id
    )&.role
  end

  def user_is_org_owner?
    current_user.memberships.where(
      organisation_id: organisation.id,
      role: Memberships::Roles::OWNER
    ).exists?
  end

  def user_is_admin?
    current_user.memberships.where(
      organisation_id: organisation.id,
      role: Memberships::Roles::ADMIN
    ).exists?
  end

  def record_belongs_to_user?
    record.user == current_user
  end

  def organisation
    @organisation ||= record.space.organisation
  end

  class Scope < BaseScope
    def resolve
      scope.where(user_id: current_user.id)
    end
  end
end
