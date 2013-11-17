class News < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:title, :content, :date_of_publication]
  end

  def self.newest
    all.sort do |news_a, news_b|
      news_b.date_of_publication <=> news_a.date_of_publication
    end
  end
end
