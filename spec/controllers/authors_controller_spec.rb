# frozen_string_literal: true

require "rails_helper"

RSpec.describe AuthorsController, type: :controller do
  let (:prints) { create_list(:print, 10) }

  describe "GET index" do
    let (:authors) { create_list(:author, 10) }
    subject { get :index }

    it "calls search_and_paginate" do
      expect(controller).to receive(:search_and_paginate).with(Author).and_return(authors)
      subject
    end

    it "assigns @authors" do
      allow(controller).to receive(:search_and_paginate).with(Author).and_return(authors)

      subject
      expect(assigns(:authors)).to eq authors
    end
  end

  describe "GET show" do
    let (:author) { create(:author, prints: prints) }

    subject { get :show, params: { id: 42 } }

    context "when author doesn't exist" do
      it "raises an error" do
        expect { get :show, params: { id: 1 } }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when author exists" do
      before :each do
        allow(Author).to receive(:find).and_return(author)
      end

      it "finds prints for author, orders and paginates them " do
        expect(Print).to receive_message_chain(:for_author, :order, :page).and_return(prints)
        subject
      end

      it "assigns @prints" do
        allow(Print).to receive_message_chain(:for_author, :order, :page).and_return(prints)
        subject

        expect(assigns(:prints)).to eq prints
      end

      it "assigns @author" do
        allow(Print).to receive_message_chain(:for_author, :order, :page).and_return(prints)
        subject

        expect(assigns(:author)).to eq author
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

      context "and author doesn't exist" do
        it "raises an error" do
          expect { delete :destroy, params: { id: 1 } }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "and author exists" do
        before :each do
          allow(Author).to receive(:find).with("42").and_return(author)
        end

        context "and has prints" do
          let (:author) { create(:author, prints: prints) }

          it "doesn't destroy the author" do
            expect(author).not_to receive(:destroy!)
            subject
          end

          it "redirects to authors_path" do
            subject
            expect(response.redirect_url).to end_with authors_path
          end
        end

        context "and has no prints" do
          let (:author) { create(:author, prints: []) }

          it "destroys the author" do
            expect(author).to receive(:destroy!)
            subject
          end

          it "redirects to authors_path" do
            subject
            expect(response.redirect_url).to end_with authors_path
          end
        end
      end
    end
  end
end
