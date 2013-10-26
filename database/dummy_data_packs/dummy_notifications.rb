users = User.all

(1..100).each do |index|
  dummy_notification = Notification.new user_id: users[(index.remainder 9)].id,
                                        message: "You have just won #{index} dollars!!!",
                                        is_read: index.odd?
  dummy_notification.save if dummy_notification.valid?
end
