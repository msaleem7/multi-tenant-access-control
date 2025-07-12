module Organisations
  class ReadService
    def initialize(organisation_id, current_user = nil)
      @organisation_id = organisation_id
      @current_user = current_user
    end

    attr_reader :organisation_id, :current_user

    def call
      # If no current_user is provided, use Organisation.all as a fallback
      if current_user
        Organisations::ListService.new(current_user).call.find(organisation_id)
      else
        Organisation.find(organisation_id)
      end
    end
  end
end
