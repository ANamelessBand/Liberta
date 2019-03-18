# frozen_string_literal: true

require "rails_helper"

RSpec.describe TagsController, type: :controller do
  let (:prints) { create_list(:print, 10) }

  describe "GET index" do
    let (:tags) { create_list(:tag, 10) }
    subject { get :index }

    it "calls search_and_paginate" do
      expect(controller).to receive(:search_and_paginate).with(Tag).and_return(tags)
      subject
    end

    it "assigns @tags" do
      allow(controller).to receive(:search_and_paginate).with(Tag).and_return(tags)

      subject
      expect(assigns(:tags)).to eq tags
    end
  end

  describe "GET show" do
    let (:tag) { create(:tag, prints: prints) }

    subject { get :show, params: { id: 42 } }

    context "when tag doesn't exist" do
      it "raises an error" do
        expect { get :show, params: { id: 1 } }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when tag exists" do
      before :each do
        allow(Tag).to receive(:find).and_return(tag)
      end

      it "finds prints for tag, orders and paginates them " do
        expect(Print).to receive_message_chain(:for_tag, :order, :page).and_return(prints)
        subject
      end

      it "assigns @prints" do
        allow(Print).to receive_message_chain(:for_tag, :order, :page).and_return(prints)
        subject

        expect(assigns(:prints)).to eq prints
      end

      it "assigns @tag" do
        allow(Print).to receive_message_chain(:for_tag, :order, :page).and_return(prints)
        subject

        expect(assigns(:tag)).to eq tag
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

      context "and tag doesn't exist" do
        it "raises an error" do
          expect { delete :destroy, params: { id: 1 } }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "and tag exists" do
        before :each do
          allow(Tag).to receive(:find).with("42").and_return(tag)
        end

        context "and has prints" do
          let (:tag) { create(:tag, prints: prints) }

          it "doesn't destroy the tag" do
            expect(tag).not_to receive(:destroy!)
            subject
          end

          it "redirects to tags_path" do
            subject
            expect(response.redirect_url).to end_with tags_path
          end
        end

        context "and has no prints" do
          let (:tag) { create(:tag, prints: []) }

          it "destroys the tag" do
            expect(tag).to receive(:destroy!)
            subject
          end

          it "redirects to tags_path" do
            subject
            expect(response.redirect_url).to end_with tags_path
          end
        end
      end
    end
  end
end
