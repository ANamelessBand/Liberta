class Recommendation < Sequel::Model
  plugin :validation_helpers

  many_to_one :user
  many_to_one :print

  def validate
    super
    validates_presence [:user_id, :print_id, :rating]
    validates_includes [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5], :rating
  end
end
