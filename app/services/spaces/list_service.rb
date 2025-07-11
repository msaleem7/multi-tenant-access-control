module Spaces
  class ListService
    def initialize(current_user, organisation_id, params = {})
      @current_user = current_user
      @organisation_id = organisation_id
      @params = params
    end

    attr_reader :current_user, :organisation_id, :params

    def call
      SpacesQuery.new(current_user).list(organisation_id, params)
    end
  end
end
