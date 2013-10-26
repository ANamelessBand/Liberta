class News < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:title, :content, :date_of_publication]
  end
end