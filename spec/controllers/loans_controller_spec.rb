# frozen_string_literal: true

require "rails_helper"

RSpec.describe LoansController, type: :controller do
  context "when admin" do
    sign_in_as :admin

    describe "POST create" do
      context "when copy doesn't exist" do
        it "raises an error" do
          create :user, email: "user@user.com"
          expect { post :create, params: { user: "user@user.com", copy_id: 1, print_id: 1 } }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when user doesn't exist" do
        it "raises an error" do
          expect { post :create, params: { user: "invalid", copy_id: 1, print_id: 1 } }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "when user and copy exist" do
        let (:copy) { create :copy }
        let (:user) { create :user }
        let (:params) { { user: user.email, copy_id: copy.id, print_id: copy.print.id } }
        let (:loan) { create :loan, user: user, copy: copy }

        before :each do
          allow(Copy).to receive(:find).with(copy.id.to_s).and_return(copy)
          allow(User).to receive(:find_by).with(email: user.email).and_return(user)
        end

        subject { post :create, params: params }

        redirects_back

        it "creates Loan" do
          expect(Loan).to receive(:new).and_return(loan)
          subject
        end

        it "sets user" do
          expect(Loan).to receive(:new).with(hash_including(user: user)).and_return(loan)
          subject
        end

        it "sets copy" do
          expect(Loan).to receive(:new).with(hash_including(copy: copy)).and_return(loan)
          subject
        end

        it "sets time_loaned to now" do
          subject
          expect(assigns(:loan).time_loaned).to be_within(1.second).of(Time.now)
        end

        it "sets time_supposed_return to configured offset" do
          subject
          expect(assigns(:loan).time_supposed_return).to be_within(1.second).of(Time.now + 20.days)
        end

        it "redirects back if unable to save" do
          allow(Loan).to receive(:new).and_return(loan)
          expect_any_instance_of(Loan).to receive(:save).and_return(false)
          subject

          expect(response).to redirect_back
        end

        it "redirects back" do
          allow(Loan).to receive(:new).and_return(loan)
          subject

          expect(response).to redirect_back
        end
      end
    end

    context "when loan exists" do
      let (:params) { { id: 1, print_id: 1, copy_id: 1 } }

      before :each do
        allow(Loan).to receive(:find).and_return(loan)
      end

      context "and is returned" do
        let (:loan) { create :loan, :returned }

        describe "POST return" do
          subject { post :return, params: params }

          it "redirects to copy" do
            subject
            expect(response.redirect_url).to end_with print_copy_path(loan.print, loan.copy)
          end
        end

        describe "POST extend_load" do
          subject { post :extend_loan, params: params }

          it "redirects to copy" do
            subject
            expect(response.redirect_url).to end_with print_copy_path(loan.print, loan.copy)
          end
        end
      end

      context "and is unreturned" do
        let (:loan) { create :loan, :unreturned }

        describe "POST return" do
          subject { post :return, params: params }

          redirects_back

          it "assigns loan" do
            subject
            expect(assigns(:loan)).to eq loan
          end

          it "returns loan" do
            expect(loan).to receive(:return!)
            subject
          end

          it "notifies users" do
            expect(loan.print).to receive(:notify_copy_returned!)
            subject
          end

          it "redirects_back" do
            expect(subject).to redirect_back
          end
        end

        describe "POST extend_loan" do
          subject { post :extend_loan, params: params }

          redirects_back

          it "assigns loan" do
            subject
            expect(assigns(:loan)).to eq loan
          end

          it "extends loan" do
            expect(loan).to receive(:extend!)
            subject
          end

          it "redirects_back" do
            expect(subject).to redirect_back
          end
        end
      end
    end

    context "when loan doesn't exist" do
      let (:params) { { id: 1, print_id: 1, copy_id: 1 } }

      describe "POST return" do
        it "raises an error" do
          expect { post :return, params: params }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      describe "POST extend_loan" do
        it "raises an error" do
          expect { post :extend_loan, params: params }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe "POST return" do
      it "assigns loan" do
      end
    end
  end

  context "when not admin" do
    sign_in_as :user

    describe "POST create" do
      it "denies access" do
        post :create, params: { print_id: 1, copy_id: 1 }
        expect(response).to deny_access
      end
    end

    describe "POST return" do
      it "denies access" do
        post :return, params: { id: 1, print_id: 1, copy_id: 1 }
        expect(response).to deny_access
      end
    end

    describe "POST extend_loand" do
      it "denies access" do
        post :extend_loan, params: { id: 1, print_id: 1, copy_id: 1 }
        expect(response).to deny_access
      end
    end
  end
end
