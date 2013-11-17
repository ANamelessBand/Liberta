class Print < Sequel::Model
  many_to_many :authors
  many_to_many :tags
  many_to_one :format
  many_to_one :publisher
  one_to_many :copies
  one_to_many :recommendations
  one_to_many :wishlists

  def rating(last_month = false)
    ratings = recommendations

    if ratings.empty?
      0
    else
      ratings.map(&:rating).reduce(:+) / ratings.size
    end
  end

  def rating_last_month
    ratings = recommendations.select do |recommendation|
      (Date.today - recommendation.date_of_comment).to_i <= 30
    end

    if ratings.empty?
      0
    else
      ratings.map(&:rating).reduce(:+) / ratings.size
    end
  end

  def copies_count
    copies.size
  end

  def free_copies
    copies.reject(&:is_taken)
  end

  def taken_copies
    copies.select(&:is_taken)
  end

  def authors_string
    authors.map(&:name).join ' '
  end

  def tags_string
    tags.map(&:name).join ' '
  end

  def searchables_string
    [title, authors_string, tags_string, publisher.name].join ' '
  end

  def self.newest
    all.sort do |book_a, book_b|
      book_b.date_added <=> book_a.date_added
    end
  end
end
