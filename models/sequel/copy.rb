#done
class Copy < Sequel::Model
	many_to_one :prints
end