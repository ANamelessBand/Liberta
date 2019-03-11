class Format < Sequel::Model
  plugin :validation_helpers

  one_to_many :prints

  def validate
    validates_presence :name
  end
end
