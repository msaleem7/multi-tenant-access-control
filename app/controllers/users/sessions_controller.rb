class Users::SessionsController < Devise::SessionsController
  # Override the default after_sign_in_path_for method
  protected
  
  def after_sign_in_path_for(resource)
    organisations_path
  end
end
