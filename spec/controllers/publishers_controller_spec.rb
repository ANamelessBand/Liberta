# frozen_string_literal: true

require "rails_helper"

RSpec.describe PublishersController, type: :controller do
  let (:prints) { create_list(:print, 10) }

  describe "GET index" do
    let (:publishers) { create_list(:publisher, 10) }
    subject { get :index }

    it "calls search_and_paginate" do
      expect(controller).to receive(:search_and_paginate).with(Publisher).and_return(publishers)
      subject
    end

    it "assigns @publishers" do
      allow(controller).to receive(:search_and_paginate).with(Publisher).and_return(publishers)

      subject
      expect(assigns(:publishers)).to eq publishers
    end
  end

  describe "GET show" do
    let (:publisher) { create(:publisher, :with_prints) }

    subject { get :show, params: { id: 42 } }

    context "when publisher doesn't exist" do
      it "raises an error" do
        expect { get :show, params: { id: 1 } }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when publisher exists" do
      before :each do
        allow(Publisher).to receive(:find).and_return(publisher)
      end

      it "finds prints for publisher, orders and paginates them " do
        expect(Print).to receive_message_chain(:for_publisher, :order, :page).and_return(prints)
        subject
      end

      it "assigns @prints" do
        allow(Print).to receive_message_chain(:for_publisher, :order, :page).and_return(prints)
        subject

        expect(assigns(:prints)).to eq prints
      end

      it "assigns @publisher" do
        allow(Print).to receive_message_chain(:for_publisher, :order, :page).and_return(prints)
        subject

        expect(assigns(:publisher)).to eq publisher
      end
    end
  end

  describe "DELETE destroy" do
    subject { delete :destroy, params: { id: 42 } }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        subject
        expect(response).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      context "and publisher doesn't exist" do
        it "raises an error" do
          expect { delete :destroy, params: { id: 1 } }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "and publisher exists" do
        before :each do
          allow(Publisher).to receive(:find).with("42").and_return(publisher)
        end

        context "and has prints" do
          let (:publisher) { create(:publisher, :with_prints) }

          it "doesn't destroy the publisher" do
            expect(publisher).not_to receive(:destroy!)
            subject
          end

          it "redirects to publishers_path" do
            subject
            expect(response.redirect_url).to end_with publishers_path
          end
        end

        context "and has no prints" do
          let (:publisher) { create(:publisher) }

          it "destroys the publisher" do
            expect(publisher).to receive(:destroy!)
            subject
          end

          it "redirects to publishers_path" do
            subject
            expect(response.redirect_url).to end_with publishers_path
          end
        end
      end
    end
  end
end
