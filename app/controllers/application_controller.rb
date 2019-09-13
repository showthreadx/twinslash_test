class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, notice: 'You have not enough rights to do this action.'
  end
end
