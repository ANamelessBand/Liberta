class Recommendation < Sequel::Model
  plugin :validation_helpers

  many_to_one :users
  many_to_one :prints

  def validate
    super
    validates_presence [:user_id, :print_id, :rating]
    validates_includes (1..5).to_a, :rating
  end
end
