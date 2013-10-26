class Author < Sequel::Model
  plugin :validarion_helpers
  def validate
    super
    validates_presence :name
end