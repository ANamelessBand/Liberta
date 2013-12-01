class Print < Sequel::Model
  many_to_many :authors
  many_to_many :tags
  many_to_one :format
  many_to_one :publisher
  one_to_many :copies
  one_to_many :recommendations
  one_to_many :wishlists

  def rating
    ratings = recommendations_dataset.map :rating

    if ratings.empty?
      0
    else
      ratings.reduce(:+) / ratings.count
    end
  end

  def rating_last_month
    ratings = recommendations_dataset.
      where(date_of_comment: ((Date.today - 31)..Date.today)).map :rating

    if ratings.empty?
      0
    else
      ratings.reduce(:+) / ratings.count
    end
  end

  def free_copies
    copies_dataset.where is_taken: false
  end

  def loaned_copies
    copies_dataset.where is_taken: true
  end

  def out_of_copies?
    copies_dataset.where(is_taken: false).count.zero?
  end

  def last_recommendations
    recommendations_dataset.reverse_order :date_of_comment, :id
  end

  class << self

    def oldest
      order :date_added, :id
    end

    def newest
      reverse_order :date_added, :id
    end

    def best
      # TODO add a rating roll in the print table.
      all.sort do |print_a, print_b|
        print_b.rating <=> print_a.rating
      end
    end

    def best_last_month
      all.sort do |print_a, print_b|
        print_b.rating_last_month <=> print_a.rating_last_month
      end
    end
  end
end
