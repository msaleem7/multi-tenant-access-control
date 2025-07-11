# frozen_string_literal: true

class OrganisationsQuery < BaseQuery
  def self.model
    Organisation
  end

  def list(params = {})
    scope
  end
end
