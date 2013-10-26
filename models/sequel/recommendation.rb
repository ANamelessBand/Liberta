class Recommendation < Sequel::Model
  plugin :validation_helpers

  many_to_one :user
  many_to_one :print

  def validate
    super
    validates_presence [:user_id, :print_id, :rating]
    validates_includes (1..5).to_a, :rating
  end
end
