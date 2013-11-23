class Loan < Sequel::Model
  plugin :validation_helpers

  many_to_one :copy
  many_to_one :user

  def validate
    super
    validates_presence [:date_loaned, :date_supposed_return]
  end
end
