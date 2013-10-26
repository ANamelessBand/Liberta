class Publisher < Sequel::Model
  plugin validation_helpers:

  def validate
    validates_presence :name
  end
end
