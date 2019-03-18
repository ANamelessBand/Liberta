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
      expect { subject }.to raise_error ActiveRecord::RecordNotFound
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

      before do
        allow(Print).to receive(:find).and_return(print)
      end

      context "with valid params" do
        redirects_back

        let (:params) do
          { print_id: print.id, copy: { inventory_number: 1 } }
        end

        subject { post :create, params: params }

        before { allow(Copy).to receive(:new).and_return(copy) }

        it { should permit(:inventory_number).for(:create, params: params).on(:copy) }

        it "looks up print by print_id" do
          expect(Print).to receive(:find).with(print.id.to_s)
          subject
        end

        it "assigns the new @copy" do
          subject
          expect(assigns(:copy)).to eq copy
        end

        it "redirects back" do
          subject
          expect(response).to redirect_back
        end
      end

      context "with invalid params" do
        it "redirects to all prints" do
          post :create, params: { print_id: print.id, copy: { id: 1 } }
          expect(response.redirect_url).to end_with prints_path
        end
      end
    end
  end

  describe "DELETE destroy" do
    redirects_back

    subject { delete :destroy, params: { id: 42, print_id: 1 } }

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

      context "when copy doesn't exist" do
        it "raises an error" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
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
