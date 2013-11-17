class Print < Sequel::Model
  many_to_many :authors
  many_to_many :tags
  many_to_one :format
  many_to_one :publisher
  one_to_many :copies
  one_to_many :recommendations
  one_to_many :wishlists

  def rating(last_month = false)
    if last_month
      ratings = recommendations.select { |rec| (Date.today - rec.date_of_comment).to_i <= 30 }
    else
      ratings = recommendations
    end

    return 0 if ratings.empty?
    ratings.map(&:rating).reduce(:+) / ratings.size
  end

  def copies_count
    copies.size
  end

  def free_copies_count
    copies.reject(&:is_taken).size
  end

  def authors_string
    authors.map(&:name).join(' ')
  end

  def tags_string
    tags.map(&:name).join(' ')
  end

  def searchables_string
    [title, authors_string, tags_string, publisher.name].join(' ')
  end

  def self.take_last(count)
    all.sort{ |x, y| y.date_added <=> x.date_added }.take(count)
  end

  def search_matches(matchers, field)
    matchers.map { |matcher| result.send(field).downcase.include?(matcher.downcase) }.all?
  end
end
