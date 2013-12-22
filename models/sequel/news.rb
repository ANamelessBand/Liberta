class News < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:title, :content, :date_of_publication]
  end

  class << self
    def oldest
      order :date_of_publication, :id
    end

    def newest
      reverse_order :date_of_publication, :id
    end
  end
end
