# frozen_string_literal: true

require "rails_helper"

RSpec.describe AdminController, type: :controller do
  subject { get :index }

  context "when not admin" do
    sign_in_as :user

    it "denies access" do
      subject
      expect(response).to deny_access
    end
  end

  context "when admin" do
    sign_in_as :admin

    describe "GET index" do
      let (:copy)     { create(:copy) }
      let (:overdue1) { create(:copy, :overdue) }
      let (:overdue2) { create(:copy, :overdue) }
      let (:copies)   { [copy, overdue1, overdue2] }

      let (:wishlists) { FactoryBot.create_list(:wishlist, 5) }

      it "assigns all @wishlists" do
        expect(Wishlist).to receive(:all).and_return(wishlists)
        subject

        expect(assigns(:wishlists)).to eq wishlists
      end

      it "assigns @overdue copies" do
        expect(Copy).to receive(:all).and_return(copies)
        subject

        expect(assigns(:overdue)).to eq [overdue1, overdue2]
      end
    end
  end
end
