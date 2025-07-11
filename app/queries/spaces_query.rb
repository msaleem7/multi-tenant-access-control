# frozen_string_literal: true

class SpacesQuery < BaseQuery
  def self.model
    Space
  end

  def list(organisation_id, params = {})
    @organisation_id = organisation_id

    filter(params)
    scope
  end

  private

  attr_reader :organisation_id

  def filter(params)
    filter_by_organisation
  end

  def filter_by_organisation
    @scope = scope.where(organisation_id: organisation_id)
  end
end
