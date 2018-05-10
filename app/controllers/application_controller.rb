class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :config_devise_params, if: :devise_controller?

  protected
    def config_devise_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
