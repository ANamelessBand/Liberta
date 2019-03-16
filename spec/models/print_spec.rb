# frozen_string_literal: true

require "rails_helper"

RSpec.describe Print, type: :model do
  it { is_expected.to have_many :copies }
  it { is_expected.to have_many :recommendations }
  it { is_expected.to have_many :wishlists }

  it { is_expected.to belong_to :publisher }

  it { is_expected.to have_and_belong_to_many :tags }
  it { is_expected.to have_and_belong_to_many :authors }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :language }
  it { is_expected.to validate_presence_of :publisher_id }

  subject { create(:print) }

  describe "::best" do
    it "returns the best prints by rating" do
      print1 = create(:print)
      print2 = create(:print)
      print3 = create(:print)

      create(:recommendation, print: print1, rating: 4)
      create(:recommendation, print: print2, rating: 3)
      create(:recommendation, print: print3, rating: 2)

      expect(Print.best.take(2)).to match_array [print1, print2]
    end
  end

  describe "#author_names" do
    it "returns a comma-separated list of author names" do
      author1 = create(:author, name: "author 1")
      author2 = create(:author, name: "author 2")
      author3 = create(:author, name: "author 3")

      subject.authors << author1 << author3

      expect(subject.author_names).to eq "author 1, author 3"
    end

    it "returns empty string if there are no authors" do
      expect(subject.author_names).to eq ""
    end
  end

  describe "#tag_names" do
    it "returns a comma-separated list of tag names" do
      tag1 = create(:tag, name: "tag 1")
      tag2 = create(:tag, name: "tag 2")
      tag3 = create(:tag, name: "tag 3")

      subject.tags << tag1 << tag3

      expect(subject.tag_names).to eq "tag 1, tag 3"
    end

    it "returns empty string if there are no tags" do
      expect(subject.tag_names).to eq ""
    end
  end

  describe "#rating" do
    it "returns the average rating" do
      create(:recommendation, print: subject, rating: 1)
      create(:recommendation, print: subject, rating: 2)

      expect(subject.rating).to be 1.5
    end

    it "returns 0 if there are no ratings" do
      expect(subject.rating).to be 0.0
    end
  end

  describe "#free_copies" do
    it "returns all free copies" do
      copy1 = create(:copy, print: subject)
      copy2 = create(:copy, print: subject)
      copy3 = create(:copy, :loaned, print: subject)

      expect(subject.free_copies).to eq [copy1, copy2]
    end

    it "returns an empty array if there are no copies" do
      expect(subject.free_copies).to be_empty
    end
  end

  describe "#has_copies?" do
    it "returns true if there is a free copy" do
      create(:copy, print: subject)
      expect(subject.has_copies?).to be true
    end

    it "returns false if there are no free copies" do
      create(:copy, :loaned, print: subject)
      expect(subject.has_copies?).to be false
    end
  end

  describe "#last_recommendations" do
    it "returns the last 5 recommendations of this print" do
      recommendations = (0...10).to_a.map { create(:recommendation, print: subject) }
      expect(subject.last_recommendations).to match_array recommendations.last(5)
    end

    it "returns an empty array if there are no recommendations" do
      expect(subject.last_recommendations).to be_empty
    end
  end
end
