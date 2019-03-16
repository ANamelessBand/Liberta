# frozen_string_literal: true

require "rails_helper"

RSpec.describe Loan, type: :model do
  it { is_expected.to belong_to :copy }
  it { is_expected.to belong_to :user }

  subject { create(:loan) }

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
