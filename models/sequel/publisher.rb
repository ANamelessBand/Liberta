#done
class Publisher < Sequel::Model
  one_to_many :prints

  plugin :validation_helpers

  def validate
    validates_presence :name
  end
end
