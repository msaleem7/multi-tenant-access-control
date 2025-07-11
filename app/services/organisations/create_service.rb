module Organisations
  class CreateService
    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call
      authorize!

      organisation.save!
      organisation
    end

    private

    def organisation
      @organisation ||= Organisation.new(params)
    end

    def authorize!
      Pundit.authorize(current_user, organisation, :create?)
    end
  end
end