# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many :recommendations }
  it { is_expected.to have_many :notifications }
  it { is_expected.to have_many :wishlists }
  it { is_expected.to have_many :loans }

  subject { create(:user) }

  describe "#unread_notifications?" do
    it "is true when the user has unread notifications" do
      subject.notifications << create(:notification, :read, user: subject)
      subject.notifications << create(:notification, :unread, user: subject)

      expect(subject.unread_notifications?).to be true
    end

    it "is false when the user has no unread notifications" do
      subject.notifications << create(:notification, :read, user: subject)
      subject.notifications << create(:notification, :read, user: subject)

      expect(subject.unread_notifications?).to be false
    end
  end

  context "has a print added to their wishlist" do
    before :each do
      @print = create(:print)
      @wishlist = create(:wishlist, user: subject, print: @print)
    end

    describe "#wish?" do
      it "is true for that print" do
        expect(subject.wish? @print).to be true
      end
    end

    describe "wish_for" do
      it "returns all wishlist entries for that print" do
        expect(subject.wish_for @print).to eq @wishlist
      end
    end
  end

  context "has no prints added to their wishlist" do
    before :each do
      @print = create(:print)
    end

    describe "#wish?" do
      it "is false for any print" do
        expect(subject.wish? @print).to be false
      end
    end

    describe "wish_for" do
      it "returns empty for any print" do
        expect(subject.wish_for @print).to be_nil
      end
    end
  end

  describe "#loaned_prints" do
    it "returns all loaned prints" do
      print1 = create(:print)
      copy1 = create(:copy, print: print1)
      print2 = create(:print)
      copy2 = create(:copy, print: print2)
      print3 = create(:print)
      copy3 = create(:copy, print: print3)

      loan1 = create(:loan, user: subject, copy: copy1)
      loan2 = create(:loan, user: subject, copy: copy3)

      expect(subject.loaned_prints).to eq [print1, print3]
    end

    it "is empty if the user has no loaned prints" do
      expect(subject.loaned_prints).to be_empty
    end
  end

  describe "#has_recommended?" do
    it "is true when the user has recommended a given print" do
      print = create(:print)
      create(:recommendation, user: subject, print: print)

      expect(subject.has_recommended? print).to be true
    end

    it "is false when the user hasn't recommended a given print" do
      print = create(:print)
      expect(subject.has_recommended? print).to be false
    end
  end
end
