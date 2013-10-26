class Copy < Sequel::Model
  many_to_one :print
  one_to_many :loans
end
