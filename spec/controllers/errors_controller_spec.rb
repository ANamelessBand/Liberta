# frozen_string_literal: true

require "rails_helper"

RSpec.describe ErrorsController, type: :controller do
  describe "GET not_found" do
    setup { get :not_found }
    it { should render_template("errors/error") }
  end

  describe "GET unacceptable" do
    setup { get :unacceptable }
    it { should render_template("errors/error") }
  end

  describe "GET internal_error" do
    setup { get :internal_error }
    it { should render_template("errors/error") }
  end
end
