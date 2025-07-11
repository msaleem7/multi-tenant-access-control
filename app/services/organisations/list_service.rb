module Organisations
  class ListService
    def call
      Organisation.all
    end
  end
end
