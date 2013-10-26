users = User.all
prints = Print.all

(1..100).each do |index|
  dummy_wishlist = Wishlist.new user_id: users[(index.remainder 9)].id,
                                print_id: prints[(index.remainder 6)].id,
                                is_satisfied: [true, false].sample
  dummy_wishlist.save if dummy_wishlist.valid?
end
