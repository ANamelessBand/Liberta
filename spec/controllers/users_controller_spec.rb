# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET index" do
    let (:users) { create_list(:user, 10) }
    subject { get :index }

    it "calls search_and_paginate" do
      expect(controller).to receive(:search_and_paginate).with(User, :email).and_return(users)
      subject
    end

    it "assigns @users" do
      allow(controller).to receive(:search_and_paginate).with(User, :email).and_return(users)

      subject
      expect(assigns(:users)).to eq users
    end

    it "renders index template" do
      expect(subject).to render_template :index
    end
  end

  describe "GET show" do
    sign_in_as :user # Needed because breadcrumbs use current_user

    subject { get :show, params: { id: 42 } }

    context "when user exists" do
      let (:user) { create :user }

      before :each do
        allow(User).to receive(:find).and_return(user)
      end

      it "assings @user" do
        subject
        expect(assigns(:user)).to eq user
      end

      it "renders show template" do
        subject
        expect(subject).to render_template :show
      end
    end

    context "when user doesn't exist" do
      it "raises an error if print doesn't exist" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST mark_notifications_as_read" do
    subject { post :mark_notifications_as_read, params: { id: 42 } }

    context "when not signed in" do
      sign_out

      it "denies access" do
        subject
        expect(response).to deny_access
      end
    end

    context "when signed in" do
      sign_in_as :user

      context "when user doesn't exist" do
        it "raises an error if user doesn't exist" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when user exists" do
        let (:user) { create :user }
        redirects_back

        before :each do
          allow(User).to receive(:find).and_return(user)
        end

        it "marks users' notifications as read" do
          expect(user).to receive(:mark_notifications_as_read!)
          subject
        end

        it "redirects back" do
          subject
          expect(response).to redirect_back
        end
      end
    end
  end

  describe "POST make_admin" do
    subject { post :make_admin, params: { id: 42 } }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        subject
        expect(response).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      context "when user doesn't exist" do
        it "raises an error if user doesn't exist" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when user exists" do
        let (:user) { create :user }
        redirects_back

        before :each do
          allow(User).to receive(:find).and_return(user)
        end

        it "makes user admin" do
          expect(user).to receive(:save!)
          subject
          expect(user.admin).to be true
        end

        it "redirects back" do
          subject
          expect(response).to redirect_back
        end
      end
    end
  end

  describe "POST revoke_admin" do
    subject { post :revoke_admin, params: { id: 42 } }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        subject
        expect(response).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      context "when user doesn't exist" do
        it "raises an error if user doesn't exist" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when user exists" do
        let (:user) { create :user }
        redirects_back

        before :each do
          allow(User).to receive(:find).and_return(user)
        end

        it "revokes admin rights" do
          expect(user).to receive(:save!)
          subject
          expect(user.admin).to be false
        end

        it "redirects back" do
          subject
          expect(response).to redirect_back
        end
      end
    end
  end

  describe "POST custom_create" do
    subject { post :custom_create, params: { email: "test@admin.com" } }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        subject
        expect(response).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin
      redirects_back

      let (:user) { create :user }

      before :each do
        allow(Faker::Internet).to receive(:password).and_return("random password")
      end

      it "generates a fake password" do
        expect(Faker::Internet).to receive(:password).and_return("random password")
        subject
      end

      it "creates user" do
        expect(User).to receive(:new)
            .with(email: "test@admin.com", password: "random password", password_confirmation: "random password")
            .and_return(user)

        subject
      end

      it "saves user" do
        allow(User).to receive(:new)
            .with(email: "test@admin.com", password: "random password", password_confirmation: "random password")
            .and_return(user)

        expect(user).to receive(:save!)

        subject
      end

      it "redirects back" do
        subject
        expect(response).to redirect_back
      end
    end
  end

  describe "POST custom_delete" do
    subject { post :custom_delete, params: { id: 42 } }

    context "when not admin" do
      sign_in_as :user

      it "denies access" do
        subject
        expect(response).to deny_access
      end
    end

    context "when admin" do
      sign_in_as :admin

      context "when user doesn't exist" do
        it "raises an error if user doesn't exist" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when user exists" do
        let (:user) { create :user }
        redirects_back

        it "deletes user" do
          expect(User).to receive(:destroy).with("42")
          subject
        end

        it "redirects back" do
          allow(User).to receive(:destroy).with("42")
          subject
          expect(response).to redirect_back
        end
      end
    end
  end
end
