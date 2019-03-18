# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout "devise_custom", only: [:new]
end
