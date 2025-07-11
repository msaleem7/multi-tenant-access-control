module Spaces
  class UpdateService
    def initialize(current_user, space, params)
      @current_user = current_user
      @space = space
      @params = params
    end

    attr_reader :current_user, :space, :params

    def call
      authorize!
      space.update!(params)
      space
    end

    private

    def authorize!
      Pundit.authorize(current_user, space, :update?)
    end
  end
end
