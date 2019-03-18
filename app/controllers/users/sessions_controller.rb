# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "devise_custom", only: [:new]
end
