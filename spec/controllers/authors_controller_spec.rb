# frozen_string_literal: true

require "rails_helper"

RSpec.describe AuthorsController, type: :controller do
  describe "GET index" do
    let (:authors) { FactoryBot.create_list(:author, 10) }

    it "assigns @authors" do
      expect(controller).to receive(:search_and_paginate).with(Author).and_return(authors)

      get :index
      expect(assigns(:authors)).to eq authors
    end
  end

  describe "GET show" do
    pending "assigns @prints"
    pending "assigns @author"
  end

  describe "DELETE destroy" do
    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        delete :destroy, params: { id: 1 }
        expect(response).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      pending "redirects when prints empty"
      pending "deletes author"
    end
  end
end
