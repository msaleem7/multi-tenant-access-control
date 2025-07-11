module Organisations
  class ListService
    def initialize(current_user, params = {})
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call
      OrganisationsQuery.new(current_user).list(params)
    end
  end
end
