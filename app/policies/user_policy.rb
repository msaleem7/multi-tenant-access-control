class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    self?
  end

  def update?
    self?
  end

  def destroy?
    self?
  end

  private

  def self?
    user == record
  end

  class Scope < BaseScope
    def resolve
      scope
    end
  end
end
