class PostPolicy < ApplicationPolicy
  def create?
    true
  end

  def new?
    true
  end

  def show?
    true
  end

  def update?
    user_is_the_creator?
  end

  def destroy?
    user_is_the_creator? || user_is_org_owner_or_admin?
  end

  private

  def user_is_org_owner_or_admin?
    current_user.memberships.where(
      organisation_id: record.space.organisation_id,
      role: [Memberships::Roles::ADMIN, Memberships::Roles::OWNER]
    ).exists?
  end

  def user_is_the_creator?
    record.user == current_user
  end

  class Scope < BaseScope
    def resolve
      scope.where(space_id: current_user.spaces.ids)
    end
  end
end
