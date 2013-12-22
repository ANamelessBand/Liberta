class Author < Sequel::Model
  include PrintUtils

  plugin :validation_helpers

  many_to_many :prints

  def validate
    super
    validates_presence :name
  end
end
