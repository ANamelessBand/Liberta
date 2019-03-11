class Publisher < Sequel::Model
  include PrintUtils

  plugin :validation_helpers

  one_to_many :prints

  def validate
    super
    validates_presence :name
  end
end
