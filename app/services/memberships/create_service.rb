module Memberships
  class CreateService
    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call
      authorize!

      membership.save!
      membership
    end

    private

    def membership
      @membership ||= Membership.new(params)
    end

    def authorize!
      Pundit.authorize(current_user, membership, :create?)
    end
  end
end
