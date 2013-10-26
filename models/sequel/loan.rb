class Loan < Sequel::Model
  one_to_one :copie
  many_to_one :user
end


