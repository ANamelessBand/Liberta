# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecommendationsController, type: :controller do
  context "when signed in" do
    sign_in_as :user

    let (:print) { create(:print) }

    before :each do
      allow(Print).to receive(:find).and_return(print)
    end

    describe "POST create" do
      let (:params) do
        -> (rating = 3.0) do
          { print_id: 1, rating: rating, recommendation: { comment: "test" } }
        end
      end

      subject { post :create, params: params[] }

      it "creates Recommendation" do
        expect(Recommendation).to receive(:create!)
        subject
      end

      it "converts rating to float" do
        expect(Recommendation).to receive(:create!).with(hash_including(rating: 2.0))
        post :create, params: params[2]
      end

      it "sets user to current user" do
        expect(Recommendation).to receive(:create!).with(hash_including(user: current_user))
        subject
      end

      it "sets the print" do
        expect(Recommendation).to receive(:create!).with(hash_including(print: print))
        subject
      end

      it "sets comment if it exists" do
        expect(Recommendation).to receive(:create!).with(hash_including(comment: "test"))
        subject
      end

      it "redirects to print" do
        subject
        expect(response.redirect_url).to end_with print_path(print)
      end
    end

    describe "DELETE destroy" do
      subject { delete :destroy, params: { print_id: 1, id: recommendation.id } }

      context "when recommendation user is different than current user" do
        let (:recommendation) { create(:recommendation, user: create(:user)) }

        it "denies access" do
          subject
          expect(response).to deny_access
        end

        context "and admin" do
          sign_in_as :admin

          it "doesn't deny access" do
            subject
            expect(response).not_to deny_access
          end
        end
      end

      context "when user matches" do
        let (:recommendation) { create(:recommendation, user: current_user) }

        it "destroys recommendation" do
          expect(Recommendation).to receive(:destroy).with(recommendation.id.to_s)
          subject
        end

        it "redirects to print" do
          subject
          expect(response.redirect_url).to end_with print_path(print)
        end

        context "when recommendation isn't found" do
          it "raises an error" do
            expect { delete :destroy, params: { print_id: 1, id: 2 } }.to raise_error ActiveRecord::RecordNotFound
          end
        end
      end
    end
  end

  context "when not signed in" do
    sign_out

    describe "POST create" do
      it "denies access" do
        post :create, params: { print_id: 1 }
        expect(response).to deny_access
      end
    end

    describe "DELETE destroy" do
      it "denies access" do
        delete :destroy, params: { print_id: 1, id: 2 }
        expect(response).to deny_access
      end
    end
  end
end
