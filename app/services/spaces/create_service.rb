module Spaces
  class CreateService
    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call
      authorize!

      ActiveRecord::Base.transaction do
        create_space!
        add_org_owner_and_admins_to_space!
      end

      space
    end

    private

    def authorize!
      Pundit.authorize(current_user, space, :create?)
    end

    def create_space!
      space.save!
    end

    def add_org_owner_and_admins_to_space!
      user_ids = current_user.memberships.where(
        organisation_id: space.organisation_id,
        role: [Memberships::Roles::OWNER, Memberships::Roles::ADMIN]
      ).pluck(:user_id)

      user_ids.each do |user_id|
        UserSpace.create!(user_id: user_id, space_id: space.id)
      end
    end

    def space
      @space ||= Space.new(params)
    end
  end
end
