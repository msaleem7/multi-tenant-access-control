module UserSpaces
  class CreateService
    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call
      authorize!
      validate!
      create_user_space!
    end

    private

    def authorize!
      Pundit.authorize(current_user, user_space, :create?)
    end

    def validate!
      validate_space_membership_configuration!
      validate_age_restrictions!
      validate_parental_consent!
    end

    def validate_space_membership_configuration!
      return if space_membership_configuration.blank?

      validate_space_membership_limit!
    end

    def validate_space_membership_limit!
      return if space_membership_configuration[:limit].blank?

      if current_user.spaces.where(organisation_id: organisation_id).count >= space_membership_configuration[:limit]
        raise StandardError, "You have reached the maximum number of spaces you can join in #{organisation.name}."
      end
    end

    def validate_age_restrictions!
      return if space.min_age.blank? && space.max_age.blank?

      if space.min_age.present? && current_user.age < space.min_age
        raise StandardError, "You must be at least #{space.min_age} years old to join this space."
      end

      if space.max_age.present? && current_user.age > space.max_age
        raise StandardError, "You must be under #{space.max_age} years old to join this space."
      end
    end

    def validate_parental_consent!
      return unless space.requires_parental_consent
      return if current_user.parental_consent

      raise StandardError, "Parental consent is required to join this space."
    end

    def space_membership_configuration
      return {} if organisation.configuration.blank? || organisation.configuration[:space_membership].blank?
      @space_membership_configuration ||= organisation.configuration[:space_membership].symbolize_keys
    end

    def create_user_space!
      user_space.save!
      user_space
    end

    def user_space
      @user_space ||= UserSpace.new(
        user: current_user,
        space: space
      )
    end

    def space
      @space ||= Space.find_by(id: params[:space_id])
    end

    def existing_spaces
      return Space.none unless space
      @existing_spaces ||= Spaces::ListService.new(current_user, space.organisation_id).call
    end

    def organisation
      @organisation ||= space.organisation
    end
  end
end
