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

  subject { create(:print) }

  describe "::for_author" do
    it "returns the prints for a given author" do
      author1 = create(:author)
      author2 = create(:author)
      print1 = create(:print, authors: [author1])
      print2 = create(:print, authors: [author1])
      create(:print, authors: [author2])
      print4 = create(:print, authors: [author1, author2])

      expect(Print.for_author(author1.id)).to match_array [print1, print2, print4]
    end
  end

  describe "::for_publisher" do
    it "returns the prints for a given publisher" do
      publisher1 = create(:publisher)
      publisher2 = create(:publisher)
      print1 = create(:print, publisher: publisher1)
      print2 = create(:print, publisher: publisher1)
      create(:print, publisher: publisher2)

      expect(Print.for_publisher(publisher1.id)).to match_array [print1, print2]
    end
  end

  describe "::for_tags" do
    it "returns the prints for a given tag" do
      tag1 = create(:tag)
      tag2 = create(:tag)
      print1 = create(:print, tags: [tag1])
      print2 = create(:print, tags: [tag1])
      create(:print, tags: [tag2])
      print4 = create(:print, tags: [tag1, tag2])

      expect(Print.for_tag(tag1.id)).to match_array [print1, print2, print4]
    end
  end

  describe "::from_google_api" do
    let (:api_print) { google_print }

    it "creates a print from a google print" do
      print = Print.from_google_api(api_print)

      expect(print.title).to eq api_print.title
      expect(print.description).to eq api_print.description
      expect(print.publisher.name).to eq api_print.publisher
      expect(print.title).to eq api_print.title
      expect(print.pages).to eq api_print.page_count
      expect(print.language).to eq api_print.language
      expect(print.authors.to_a.count).to eq api_print.authors_array.count
      expect(print.tags.to_a.count).to eq api_print.categories.split(",").count
    end
  end

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
      create(:author, name: "author 2")
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
      create(:tag, name: "tag 2")
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

  describe "#last_recommendations" do
    it "returns the last 5 recommendations of this print" do
      recommendations = (0...10).to_a.map { create(:recommendation, print: subject) }
      expect(subject.last_recommendations).to match_array recommendations.last(5)
    end

    it "returns an empty array if there are no recommendations" do
      expect(subject.last_recommendations).to be_empty
    end
  end

  describe "#free_copies" do
    it "returns all free copies" do
      copy1 = create(:copy, print: subject)
      copy2 = create(:copy, print: subject)
      copy3 = create(:copy, :loaned, print: subject)

      expect(subject.free_copies).to match_array [copy1, copy2]
      expect(subject.free_copies).not_to include copy3
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

  describe "#wished_by" do
    it "returns all the users who have added this print to their wishlist" do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      create(:wishlist, print: subject, user: user1)
      create(:wishlist, print: subject, user: user2)

      expect(subject.wished_by).to match_array [user1, user2]
      expect(subject.wished_by).not_to include user3
    end
  end

  describe "#notify_copy_returned!" do
    it "notifies all users that have this print in their wishlist that a copy has been returned" do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      create(:wishlist, print: subject, user: user1)
      create(:wishlist, print: subject, user: user2)

      subject.notify_copy_returned!

      expect(user1.notifications.unread.length).to be 1
      expect(user2.notifications.unread.length).to be 1
      expect(user3.unread_notifications?).to be false
    end
  end
end
