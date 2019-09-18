class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to request.referrer
  end
  rescue_from ActionController::UnpermittedParameters do
    flash[:warning] = 'You have not permission to update these params'
    redirect_to request.referrer
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :current_password])
  end
end
