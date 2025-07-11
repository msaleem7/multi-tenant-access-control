module Organisations
  class ReadService
    def initialize(organisation_id)
      @organisation_id = organisation_id
    end

    attr_reader :organisation_id

    def call
      Organisations::ListService.new.call.find(organisation_id)
    end
  end
end
