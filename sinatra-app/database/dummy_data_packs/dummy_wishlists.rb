users = User.all
prints = Print.all

(1..100).each do |index|
  dummy_wishlist = Wishlist.new user: users[index.remainder 9],
                                print: prints[index.remainder 6],
                                is_satisfied: [true, false].sample
  dummy_wishlist.save if dummy_wishlist.valid?
end
