Print.all.each do |print|
  (3..20).to_a.sample.times do |index|
    dummy_copy = Copy.new print: print,
                    inventory_number: (print.id * 1000) + (index * 10),
                    is_taken: false
    dummy_copy.save if dummy_copy.valid?
  end
end
