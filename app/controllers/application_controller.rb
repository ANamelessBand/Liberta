# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success

  before_action :set_time_zone

  helper_method :admin?

  add_breadcrumb "Начало", :root_path

private

  def deny_access(message = "Нямате достъп до тази страница.")
    redirect_to root_path, alert: message
  end

  def admin?
    current_user.try(:admin?)
  end

  def require_admin
    deny_access unless admin?
  end

  def set_time_zone
    Time.zone = "Sofia"
  end
end
