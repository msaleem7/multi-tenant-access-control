module Organisations
  class UpdateService
    def initialize(current_user, organisation, organisation_params)
      @current_user = current_user
      @organisation = organisation
      @organisation_params = organisation_params
    end

    attr_reader :current_user, :organisation, :organisation_params

    def call
      authorize!
      @organisation.update!(@organisation_params)
    end

    private

    def authorize!
      Pundit.authorize(current_user, organisation, :update?)
    end
  end
end
