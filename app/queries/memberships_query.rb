# frozen_string_literal: true

class MembershipsQuery < BaseQuery
  def self.model
    Membership
  end

  def list(params = {})
    filter(params)
    scope
  end

  private

  def filter(params)
    return own_memberships if params.empty?

    filter_by_organisations(params[:organisation_ids]) if params[:organisation_ids]
    filter_by_user(params[:user_id]) if params[:user_id]
    filter_by_role(params[:role]) if params[:role]
  end

  def own_memberships
    @scope = scope.where(user_id: current_user.id)
  end

  def filter_by_organisations(organisation_ids)
    @scope = scope.where(organisation_id: organisation_ids)
  end

  def filter_by_user(user_id)
    @scope = scope.where(user_id: user_id)
  end

  def filter_by_role(role)
    @scope = scope.where(role: role)
  end
end
