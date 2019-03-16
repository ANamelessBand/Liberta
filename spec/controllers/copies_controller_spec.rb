# frozen_string_literal: true

require "rails_helper"

RSpec.describe CopiesController, type: :controller do
  let (:copy) { create(:copy) }

  describe "GET show" do
    subject { get :show, params: { id: 42, print_id: 1 } }

    it "renders template" do
      allow(Copy).to receive(:find).with("42").and_return(copy)
      subject

      expect(response).to render_template
    end

    it "assigns the copy to @copy" do
      expect(Copy).to receive(:find).with("42").and_return(copy)
      subject

      expect(assigns(:copy)).to eq copy
    end

    it "shows an error when the copy isn't found" do
      expect{ subject }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "POST create" do
    context "when regular user" do
      sign_in_as :user

      it "denies access" do
        post :create, params: { print_id: 1 }
        expect(response).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      let (:print) { create(:print) }
      before { allow(Print).to receive(:find).and_return(print) }

      context "with valid params" do
        redirect_back

        let (:params) do
          { print_id: print.id, copy: { inventory_number: 1} }
        end

        before { allow(Copy).to receive(:new).and_return(copy) }

        it { should permit(:inventory_number).for(:create, params: params).on(:copy) }

        it "looks up print by print_id" do
          expect(Print).to receive(:find).with(print.id.to_s)
          post :create, params: params
        end

        it "assigns the new @copy" do
          post :create, params: params
          expect(assigns(:copy)).to eq copy
        end

        it "redirects back" do
          post :create, params: params
          expect(response).to redirect_back
        end
      end

      it "redirects to all prints when unable to save" do
        post :create, params: { print_id: print.id, copy: { id: 1 } }
        expect(response.redirect_url).to end_with prints_path
      end
    end
  end

  describe "DELETE destroy" do
    subject { delete :destroy, params: { id: 42, print_id: 1 } }

    redirect_back

    context "when admin" do
      sign_in_as :admin

      it "deletes the copy if found" do
        expect(Copy).to receive(:destroy).with("42")
        subject
      end

      it "redirects back" do
        allow(Copy).to receive(:destroy).with("42")
        subject
        expect(response).to redirect_back
      end
    end

    context "when regular user" do
      sign_in_as :user

      it "denies access" do
        subject
        expect(response).to deny_access
      end
    end
  end
end
