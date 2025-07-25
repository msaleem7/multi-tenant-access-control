# frozen_string_literal: true

module DeviseWhitelist
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :parental_consent, :age])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :parental_consent, :age])
  end
end
