# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsController, type: :controller do
  context "when admin" do
    sign_in_as :admin

    describe "POST create" do
      context "with valid params" do
        let (:params) do
          { news: { title: 'test', content: 'test content' } }
        end

        it { should permit(:title, :content).for(:create, params: params).on(:news) }

        it "creates the news" do
          expect(News).to receive(:create!)
          post :create, params: params
        end

        it "redirects to the home page" do
          post :create, params: params
          expect(response).to redirect_to root_path
        end
      end

      it "throws an error with invalid parameters" do
        expect { post :create, params: { news: { title: 'test' } } }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    describe "DELETE destroy" do
      subject { delete :destroy, params: { id: 42 } }
      let (:news) { create(:news) }

      it "deletes the news if found" do
        expect(News).to receive(:destroy).with("42")
        subject
      end

      it "redirects to the home page" do
        allow(News).to receive(:destroy).with("42").and_return(news)
        subject
        expect(response).to redirect_to root_path
      end
    end
  end

  context "when regular user" do
    sign_in_as :user

    describe "POST create" do
      it "denies access" do
        post :create
        expect(response).to deny_access
      end
    end

    describe "DELETE destroy" do
      it "denies access" do
        delete :destroy, params: { id: '1' }
        expect(response).to deny_access
      end
    end
  end
end
