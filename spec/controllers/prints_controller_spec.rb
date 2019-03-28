# frozen_string_literal: true

require "rails_helper"

RSpec.describe PrintsController, type: :controller do
  describe "GET index" do
    let (:prints) { create_list(:print, 10) }
    subject { get :index }

    it "calls search_and_paginate" do
      expect(controller).to receive(:search_and_paginate).with(Print, :title).and_return(prints)
      subject
    end

    it "assigns @prints" do
      allow(controller).to receive(:search_and_paginate).with(Print, :title).and_return(prints)

      subject
      expect(assigns(:prints)).to eq prints
    end

    it "renders index template" do
      expect(subject).to render_template :index
    end
  end

  describe "GET best" do
    let (:prints) { create_list(:print, 20) }
    subject { get :best }

    it "calls ::best" do
      expect(Print).to receive(:best).and_return(prints)
      subject
    end

    it "gets the first 10 prints" do
      allow(Print).to receive(:best).and_return(prints)
      expect(prints).to receive(:take).with(10)
      subject
    end

    it "assigns @prints" do
      allow(Print).to receive(:best).and_return(prints)

      subject
      expect(assigns(:prints)).to eq prints.take(10)
    end
  end

  describe "GET show" do
    let (:print) { create :print }
    subject { get :show, params: { id: 42 } }

    it "assings @print" do
      allow(Print).to receive(:find).and_return(print)
      subject

      expect(assigns(:print)).to eq print
    end

    it "renders show template" do
      allow(Print).to receive(:find).and_return(print)
      subject

      expect(subject).to render_template :show
    end

    it "raises an error if print doesn't exist" do
      expect { subject }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "POST add_wishlist" do
    subject { post :add_wishlist, params: { id: 42 } }

    context "when not signed in" do
      sign_out

      it "denies access" do
        allow(Print).to receive(:find).and_return(print)
        subject
        expect(response).to deny_access
      end
    end

    context "when signed in" do
      sign_in_as :user

      it "raises an error if print doesn't exist" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end

      it "creates wishlist" do
        allow(Print).to receive(:find).and_return(print)
        expect(Wishlist).to receive(:create!).with(user: current_user, print: print)
        subject
      end
    end
  end

  describe "POST remove_wishlist" do
    subject { post :remove_wishlist, params: { id: 42 } }

    context "when not signed in" do
      sign_out

      it "denies access" do
        subject
        expect(response).to deny_access
      end
    end

    context "when signed in" do
      sign_in_as :user

      let (:wishlist) { create :wishlist }

      it "looks for wishlist" do
        expect(Wishlist).to receive(:find_by_user_id_and_print_id).with(current_user.id, "42").and_return(wishlist)
        subject
      end

      context "when wishlist found" do
        before :each do
          allow(Wishlist).to receive(:find_by_user_id_and_print_id).with(current_user.id, "42").and_return(wishlist)
        end

        it "destroys wishlist" do
          expect(wishlist).to receive(:destroy!)
          subject
        end
      end

      context "when wishlist not found" do
        it "doesn't raise errors" do
          expect { subject }.not_to raise_error
        end

        pending "returns error message"
      end
    end
  end

  describe "GET new" do
    subject { get :new }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        expect(subject).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      it "renders new form" do
        expect(subject).to render_template :new
      end
    end
  end

  describe "POST create" do
    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        expect(post :create).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      let (:params) do
        {
          print: {
            title: "test title",
            language: "en",
            format: "hard cover",
            description: "lorem ipsum",
            isbn: "1234",
            pages: 123,
            cover_url: "http://url"
          },
          authors_names: "Author1, Author2",
          publisher_name: "Publisher",
          tags: "Tag1, Tag2"
        }
      end

      subject { post :create, params: params }

      it do
        should permit(:title, :language, :format, :description, :isbn, :pages, :cover_url)
          .for(:create, params: params).on(:print)
      end

      context "when unable to save" do
        it "renders new form" do
          allow_any_instance_of(Print).to receive(:save).and_return(false)
          expect(subject).to render_template :new
        end
      end

      pending "sets associations"
    end
  end

  describe "GET edit" do
    subject { get :edit, params: { id: 1 } }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        expect(subject).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      context "when print doesn't exist" do
        it "raises an error" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when print found" do
        let (:print) { create :print }

        before :each do
          allow(Print).to receive(:find).with("1").and_return(print)
        end

        it "assigns @print" do
          expect(Print).to receive(:find).with("1").and_return(print)
          subject
          expect(assigns(:print)).to eq print
        end

        it "renders new form" do
          expect(subject).to render_template :edit
        end
      end
    end
  end

  describe "POST update" do
    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        expect(post :update, params: { id: 1 }).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      context "when print doesn't exist" do
        it "raises an error" do
          expect { post :update, params: { id: 1 } }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when print exists" do
        let (:print) { create :print }
        let (:params) do
          {
            id: "1",
            print: {
              title: "test title",
              language: "en",
              format: "hard cover",
              description: "lorem ipsum",
              isbn: "1234",
              pages: 123,
              cover_url: "http://url"
            },
            authors_names: "Author1, Author2",
            publisher_name: "Publisher",
            tags: "Tag1, Tag2"
          }
        end

        subject { post :update, params: params }

        context "when unable to save" do
          it "renders edit form" do
            allow_any_instance_of(Print).to receive(:save).and_return(false)
            expect(subject).to render_template :edit
          end
        end

        before :each do
          allow(Print).to receive(:find).with("1").and_return(print)
        end

        it do
          should permit(:title, :language, :format, :description, :isbn, :pages, :cover_url)
            .for(:update, params: params).on(:print)
        end

        pending "sets associations"
      end
    end
  end

  describe "DELETE destroy" do
    subject { delete :destroy, params: { id: 1 } }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        expect(subject).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      context "when print doesn't exist" do
        it "raises an error" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when print exists" do
        let (:print) { create :print }

        before :each do
          allow(Print).to receive(:find).with("1").and_return(print)
        end

        it "destroys print" do
          expect(print).to receive(:destroy!)
          subject
        end

        it "redirects to prints path" do
          subject
          expect(response.redirect_url).to end_with prints_path
        end
      end
    end
  end

  describe "POST choose_from_api" do
    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        expect(post :choose_from_api).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      subject { post :choose_from_api, params: { name: "test" } }

      it "makes a request to GoogleBooks" do
        expect(GoogleBooks).to receive(:search).and_return([])
        subject
      end

      it "uses name from params for request" do
        expect(GoogleBooks).to receive(:search).with("test").and_return([])
        subject
      end

      context "and the book is found" do
        let (:print_1) { google_print }
        let (:print_2) { google_print }

        before :each do
          allow(GoogleBooks).to receive(:search).and_return([print_1, print_2])
        end

        it "assings @prints" do
          subject

          expect(assigns(:prints).first).to be_a Print
          expect(assigns(:prints).first.title).to eq print_1.title
        end

        it "renders choose_from_api" do
          expect(subject).to render_template :choose_from_api
        end
      end

      context "and the book is not found" do
        before :each do
          allow(GoogleBooks).to receive(:search).and_return([])
        end

        it "redirects to all prints" do
          subject
          expect(response.redirect_url).to end_with prints_path
        end
      end
    end
  end

  describe "POST add_from_api" do
    subject { post :add_from_api, params: { isbn: "1234" } }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        expect(subject).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      let (:g_print) { google_print }
      let (:print) { create(:print) }

      it "makes a request to GoogleBooks" do
        expect(GoogleBooks).to receive(:search).and_return([g_print])
        subject
      end

      it "uses name from params for request" do
        expect(GoogleBooks).to receive(:search).with("isbn:1234").and_return([g_print])
        subject
      end

      context "and the book is found" do
        before :each do
          allow(GoogleBooks).to receive(:search).and_return([g_print])
        end

        it "converts to Print" do
          expect(Print).to receive(:from_google_api).with(g_print).and_return(print)
          subject
        end

        it "redirects to a;; prints if unable to save" do
          allow(Print).to receive(:from_google_api).with(g_print).and_return(print)
          expect(print).to receive(:save).and_return(false)

          subject
          expect(response.redirect_url).to end_with prints_path
        end

        it "redirects to saved print if saved" do
          allow(Print).to receive(:from_google_api).with(g_print).and_return(print)
          expect(print).to receive(:save).and_return(true)

          subject
          expect(response.redirect_url).to end_with print_path(print.id)
        end
      end
    end
  end
end
