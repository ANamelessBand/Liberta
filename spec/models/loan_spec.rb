# frozen_string_literal: true

require "rails_helper"

RSpec.describe Loan, type: :model do
  it { is_expected.to belong_to :copy }
  it { is_expected.to belong_to :user }

  subject { create(:loan) }

  before do
    allow(Rails.configuration).to receive(:default_loan_time).and_return(7)
  end

  describe "#new" do
    it "gets default configuration" do
      expect(Rails.configuration).to receive(:default_loan_time)
      subject
    end
  end

  describe "#time_supposed_return" do
    it "defaults to 7 days from now" do
      expect(subject.time_supposed_return).to be_within(7.days).of(Time.now)
    end
  end

  describe "#returned?" do
    it "is false by default" do
      expect(subject.returned?).to be false
    end

    it "is true when the loan has a time of return" do
      subject.time_returned = Time.now
      expect(subject.returned?).to be true
    end
  end

  describe "#unreturned?" do
    it "is true by default" do
      expect(subject.unreturned?).to be true
    end

    it "is false when the loan has been returned" do
      subject.time_returned = Time.now
      expect(subject.unreturned?).to be false
    end
  end

  describe "#overdue?" do
    it "is false by default" do
      expect(subject.overdue?).to be false
    end

    it "is true when the time of supposed return is in the past and the copy is still not returned" do
      subject.time_returned = nil
      subject.time_supposed_return = 3.days.ago
      expect(subject.unreturned?).to be true
    end

    it "is false when the time of supposed return is in the past but the copy has been returned" do
      subject.time_returned = 3.days.ago
      subject.time_supposed_return = 5.days.ago
      expect(subject.overdue?).to be false
    end
  end

  describe "#return!" do
    it "marks the loan as returned" do
      expect(subject.returned?).to be false

      subject.return!
      expect(subject.returned?).to be true
    end
  end

  describe "#extend!" do
    it "extends the loan" do
      initial_time = subject.time_supposed_return
      subject.extend!
      subject.extend!

      expect(subject.time_supposed_return).to be_within(14.days).of(initial_time)
    end
  end
end
