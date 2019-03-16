# frozen_string_literal: true

class Print < ApplicationRecord
  has_many :copies
  has_many :recommendations, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :wishlists, dependent: :destroy

  belongs_to :publisher

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :authors

  validates_presence_of :title, :language, :publisher_id

  paginates_per 10

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
