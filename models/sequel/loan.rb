#maybe done
class Loan < Sequel::Model
  one_to_one :copies
  one_to_one :users
end