module Organisations
  class DestroyService
    def initialize(current_user, organisation)
      @current_user = current_user
      @organisation = organisation
    end

    attr_reader :current_user, :organisation

    def call
      authorize!
      organisation.destroy!

      organisation
    end

    private

    def authorize!
      Pundit.authorize(current_user, organisation, :destroy?)
    end
  end
end
