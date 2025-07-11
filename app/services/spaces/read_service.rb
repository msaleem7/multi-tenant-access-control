module Spaces
  class ReadService
    def initialize(current_user, params = {})
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call(id)
      ListService.new(current_user, params).call.find(id)
    end
  end
end
