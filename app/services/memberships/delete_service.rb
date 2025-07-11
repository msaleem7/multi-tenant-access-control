module Memberships
  class DeleteService
    def initialize(current_user, membership_id)
      @current_user = current_user
      @membership_id = membership_id
    end

    attr_reader :current_user, :membership_id

    def call
      authorize!
      
      membership.destroy!
      membership
    end

    private

    def membership
      @membership ||= Membership.find(membership_id)
    end

    def authorize!
      Pundit.authorize(current_user, membership, :destroy?)
    end
  end
end
