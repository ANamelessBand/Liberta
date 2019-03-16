# frozen_string_literal: true

require "rails_helper"

RSpec.describe Copy, type: :model do
  it { is_expected.to have_many :loans }
  it { is_expected.to belong_to :print }

  it { is_expected.to validate_presence_of :print_id }
  it { is_expected.to validate_presence_of :inventory_number }
  it { is_expected.to validate_numericality_of :inventory_number }

  subject { create :copy }

  describe "#taken?" do
    it "is false by default" do
      expect(subject.taken?).to be false
    end

    it "is false when all loans are returned" do
      create(:loan, :returned, copy: subject)
      expect(subject.taken?).to be false
    end

    it "is true when there is an unreturned loan" do
      create(:loan, copy: subject)
      expect(subject.taken?).to be true
    end
  end

  describe "#free?" do
    it "is true by default" do
      expect(subject.free?).to be true
    end

    it "is true when all loans are returned" do
      create(:loan, :returned, copy: subject)
      expect(subject.free?).to be true
    end

    it "is false when there is an unreturned loan" do
      create(:loan, copy: subject)
      expect(subject.free?).to be false
    end
  end

  describe "#current_loan" do
    it "returns the current loan of the copy" do
      loan = create(:loan, copy: subject)
      expect(subject.current_loan).to eq loan
    end

    it "returns nil if the copy is not taken" do
      expect(subject.current_loan).to be_nil
    end
  end
end
