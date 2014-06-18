class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
    u.permit(:email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
    u.permit(:email, :name, :nickname, :avatar, :avatar_cache, :password, :password_confirmation, :current_password)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
    u.permit(:email, :password)
    end
  end
end
