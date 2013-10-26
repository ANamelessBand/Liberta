class Loan < Sequel::Model
  many_to_one :copy
  many_to_one :user
end


