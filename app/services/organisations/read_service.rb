module Organisations
  class ReadService
    def initialize(current_user)
      @current_user = current_user
    end

    attr_reader :current_user

    def call(organisation_id)
      Organisations::ListService.new(current_user).call.find(organisation_id)
    end
  end
end
