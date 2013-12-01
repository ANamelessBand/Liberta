class Author < Sequel::Model
  plugin :validation_helpers

  many_to_many :prints

  def validate
    super
    validates_presence :name
  end

  def top_prints
    prints.sort do |print_a, print_b|
      print_b.rating <=> print_a.rating
    end
  end

  def top_prints_for_last_month
    prints.sort do |print_a, print_b|
      print_b.rating_last_month <=> print_a.rating_last_month
    end
  end
end
