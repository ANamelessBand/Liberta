# frozen_string_literal: true

module ControllerHelpers
  def sign_in_as(role)
    let(:current_user) do
      if role == :user
        create(:user)
      else
        create(:user, role)
      end
    end

    before do
      allow(controller).to receive(:current_user).and_return(current_user)
    end
  end

  def sign_out
    before do
      allow(controller).to receive(:current_user).and_return(nil)
    end
  end

  def redirect_back
    let(:back) { "http://google.com" }
    before { request.env["HTTP_REFERER"] = back }
  end

  RSpec::Matchers.define :deny_access do
    match do |response|
      response.request.flash[:alert].present? && (response.redirect_url == "http://test.host/")
    end

    failure_message { |response| "expected action to deny access" }
  end

  RSpec::Matchers.define :redirect_back do
    match do |response|
      response.redirect_url == back
    end

    failure_message { |response| "expected action to redirect back" }
  end
end
