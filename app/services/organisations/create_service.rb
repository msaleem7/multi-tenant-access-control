module Organisations
  class CreateService
    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call
      authorize!

      ActiveRecord::Base.transaction do
        create_organisation!
        create_membership!
      end

      organisation
    end

    private

    def authorize!
      Pundit.authorize(current_user, organisation, :create?)
    end

    def create_organisation!
      organisation.save!
    end

    def create_membership!
      Memberships::CreateService.new(current_user, membership_params).call
    end

    def membership_params
      params.merge(
        user_id: current_user.id,
        organisation_id: organisation.id,
        role: Memberships::Roles::OWNER
      )
    end

    def organisation
      @organisation ||= Organisation.new(params)
    end
  end
end
