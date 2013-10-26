users = User.all
prints = Print.all

(1..100).each do |index|
  dummy_recommendation = Recommendation.new user_id: users[(index.remainder 9)].id,
                                          print_id: prints[(index.remainder 6)].id,
                                          rating: [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5].sample
  dummy_recommendation.save if dummy_recommendation.valid?
end
