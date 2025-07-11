module Spaces
  class CreateService
    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call
      authorize!

      space.save!
      space
    end

    private

    def space
      @space ||= Space.new(params)
    end

    def authorize!
      Pundit.authorize(current_user, space, :create?)
    end
  end
end
