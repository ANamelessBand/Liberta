#maybe done
class Author < Sequel::Model
  many_to_many :prints

  plugin :validarion_helpers
  def validate
    super
    validates_presence :name
end