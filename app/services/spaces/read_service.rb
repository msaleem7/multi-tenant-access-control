module Spaces
  class ReadService
    def initialize(current_user, id)
      @current_user = current_user
      @id = id
    end

    attr_reader :current_user, :id

    def call
      authorize!
      space
    end

    private

    def space
      @space ||= ListService.call.find(space_id)
    end

    def authorize!
      Pundit.authorize(current_user, space, :show?)
    end
  end
end
