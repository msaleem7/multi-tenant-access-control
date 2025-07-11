# frozen_string_literal: true

class MembershipsQuery < BaseQuery
  def self.model
    Membership
  end

  def list(params = {})
    filter(params)
  end

  private

  def filter(params)
    return @scope unless params

    @scope = by_organisations(params[:organisation_ids]) if params[:organisation_ids]
    @scope = by_user(params[:user_id]) if params[:user_id]
    @scope = by_role(params[:role]) if params[:role]

    @scope
  end

  def by_organisations(organisation_ids)
    scope.where(organisation_id: organisation_ids)
  end

  def by_user(user_id)
    scope.where(user_id: user_id)
  end

  def by_role(role)
    scope.where(role: role)
  end
end
