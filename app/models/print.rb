# frozen_string_literal: true

class Print < ApplicationRecord
  has_many :copies
  has_many :recommendations, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :wishlists, dependent: :destroy

  belongs_to :publisher

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :authors

  validates_presence_of :title, :language

  scope :for_author,    -> (author_id) { joins(:authors).where("authors.id == :id", id: author_id) }
  scope :for_publisher, -> (publisher_id) { where("publisher_id == :id", id: publisher_id) }
  scope :for_tag,       -> (tag_id) { joins(:tags).where("tags.id == :id", id: tag_id) }

  paginates_per 10

  def self.from_google_api(api_print)
    print = Print.new

    publisher_name = api_print.publisher.delete_prefix('"').delete_suffix('"')

    print.publisher = Publisher.find_or_initialize_by name: publisher_name.strip
    print.authors = api_print.authors_array
        .filter(&:present?)
        .map { |name| Author.find_or_initialize_by name: name.strip }

    print.tags = api_print.categories
        .split(",")
        .filter(&:present?)
        .map! { |name| Tag.find_or_initialize_by name: name.strip }

    print.title       = api_print.title
    print.description = api_print.description
    print.isbn        = api_print.isbn_13
    print.pages       = api_print.page_count
    print.language    = api_print.language
    print.format      = api_print.print_type
    print.cover_url   = api_print.image_link(zoom: 2)

    print
  end

  def self.best
    all.sort_by(&:rating).reverse
  end

  def author_names
    authors.map(&:name).join(", ")
  end

  def tag_names
    tags.map(&:name).join(", ")
  end

  def rating
    ratings = recommendations.map &:rating

    return 0.0 if ratings.empty?

    ratings.sum / ratings.count
  end

  def last_recommendations
    recommendations.take(5)
  end

  def free_copies
    copies.filter(&:free?)
  end

  def has_copies?
    not free_copies.empty?
  end

  def wished_by
    wishlists.map(&:user)
  end

  def notify_copy_returned!
    wished_by.each { |user| user.notify! "Върнато е копие на \"#{title}\". Свободни копия: #{free_copies.count}" }
  end
end
