class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = [:name]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def tokenized
    return nil unless params[:authentication_token]

    current_user = User.find_by_authentication_token(params[:authentication_token])
    sign_in(current_user)
  end
end
