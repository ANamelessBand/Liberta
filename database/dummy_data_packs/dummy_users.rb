names = ['Ivan Rumenov Petrov',
         'Petar Krasimirov Ivanov',
         'Nikola Kiryakov Taushanov',
         'Maria Atanasova Ignatova',
         'Violeta Ivanova Petrova',
         'Andrea Dimitrova Puleva',
         'Don Bastune De Patericci',
         'Georgi Stefanov Gardev',
         'Robert Downey Jr.',]

names.each_with_index do |name, index|
  three_names = name.split ' '
  username = three_names[0][0].concat(three_names[1][0]).concat(three_names[2]).downcase
  dummy_user = User.new username: username,
                        name: name,
                        faculty_number: 80700 + index,
                        email: "#{username}@duneparadise.com",
                        authorization_level: (index.remainder 3),
                        is_active: index.odd?
  dummy_user.save if dummy_user.valid?
end
