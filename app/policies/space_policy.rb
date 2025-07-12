class SpacePolicy < ApplicationPolicy
  def show?
    user_is_space_member?
  end

  def new?
    user_is_org_owner_or_admin?
  end

  def create?
    user_is_org_owner_or_admin?
  end

  def update?
    user_is_space_member? && user_is_org_owner_or_admin?
  end

  def destroy?
    update?
  end

  private

  def user_is_space_member?
    current_user.spaces.ids.include?(record.id)
  end

  def user_is_org_owner_or_admin?
    @user_is_org_owner_or_admin ||= current_user.memberships.where(
      organisation_id: record.organisation_id,
      role: [Memberships::Roles::ADMIN, Memberships::Roles::OWNER]
    ).exists?
  end

  class Scope < BaseScope
    def resolve
      scope.where(organisation_id: current_user.memberships.pluck(:organisation_id))
    end
  end
end
