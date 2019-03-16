# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success

  before_action :set_time_zone
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :admin?

  add_breadcrumb "Начало", :root_path

private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end

  def deny_access(message = "Нямате достъп до тази страница.")
    redirect_to root_path, alert: message
  end

  def admin?
    current_user.try(:admin?)
  end

  def require_admin
    deny_access unless admin?
  end

  def require_signed_in
    deny_access unless user_signed_in?
  end

  def set_time_zone
    Time.zone = "Sofia"
  end
end
