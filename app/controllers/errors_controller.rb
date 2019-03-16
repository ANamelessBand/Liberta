class ErrorsController < ApplicationController
  def not_found
    render 'error', status: 404
  end

  def unacceptable
    render 'error', status: 422
  end

  def internal_error
    render 'error', status: 500
  end
end
