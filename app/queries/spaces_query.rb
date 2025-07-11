# frozen_string_literal: true

class SpacesQuery < BaseQuery
  def self.model
    Space
  end

  def list(params = {})
    filter(params)
  end

  private

  def filter(params)
    return @scope unless params

    @scope = by_organisations(params[:organisation_ids]) if params[:organisation_ids]
    @scope
  end

  def by_organisations(organisation_ids)
    scope.where(organisation_id: organisation_ids)
  end
end
