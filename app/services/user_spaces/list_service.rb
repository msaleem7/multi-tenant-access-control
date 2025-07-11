module UserSpaces
  class ListService
    def initialize(current_user)
      @current_user = current_user
    end

    attr_reader :current_user

    def call
      UserSpaces::Query.new(current_user).list
    end
  end
end
