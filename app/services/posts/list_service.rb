module Posts
  class ListService
    def initialize(current_user, space, params = {})
      @current_user = current_user
      @space = space
      @params = params
    end

    attr_reader :current_user, :space, :params

    def call
      PostsQuery.new(current_user).list(space, params)
    end
  end
end
