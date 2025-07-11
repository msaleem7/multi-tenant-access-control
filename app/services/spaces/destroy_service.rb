module Spaces
  class DestroyService
    def initialize(current_user, space)
      @current_user = current_user
      @space = space
    end

    attr_reader :current_user, :space

    def call
      authorize!
      space.destroy!

      space
    end

    private

    def authorize!
      Pundit.authorize(current_user, space, :destroy?)
    end
  end
end
