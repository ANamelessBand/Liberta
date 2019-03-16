# frozen_string_literal: true

desc "Inserts realistic fake data for development purposes"
task fake: :environment do
  authors = [
    "George R. R. Martin",
    "Joe Kutner",
    "Dave Thomas",
    "Chad Fowler",
    "Andy Hunt",
    "Anne Rice",
    "Suzanne Collins",
    "J. R. R. Tоlkien",
    "Terry Pratchet",
    "Ivan Vazov",
    "Hristo Botev",
    "J. K. Rowling",
    "Douglas Addams",
    "Paulo Coelho",
    "Elin Pelin",
    "Atanas Dalchev",
  ]

  authors.each do |author_name|
    dummy_author = Author.new name: author_name
    dummy_author.save if dummy_author.valid?
  end

  tags = [
    "Roman",
    "Novel",
    "Programming",
    "Ruby",
    "Poetry",
    "Classic",
    "Fiction",
    "Fantasy",
    "Science",
    "Health",
    "History",
    "Horror",
  ]

  tags.each do |tag_name|
    dummy_tag = Tag.new name: tag_name
    dummy_tag.save if dummy_tag.valid?
  end

  publishers = [
    "Prosveta",
    "Bulvest 2000",
    "Siela-Soft",
    "Bantam Spectra",
    "The Pragmatic Bookshelf",
    "Ballantine Books",
    "Scholastic Press",
  ]

  publishers.each do |publisher_name|
    dummy_publisher = Publisher.new name: publisher_name
    dummy_publisher.save if dummy_publisher.valid?
  end

  publishers = Publisher.all
  tags = Tag.all
  authors = Author.all

  game_of_thrones = Print.new pages: 835,
                  title: "A Game of Thrones",
                  language: "english",
                  isbn: 9780553588484,
                  description: "The first volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, starring Sean Bean.

                  Summers span decades. Winter can last a lifetime. And the struggle for the Iron Throne has begun.

                  As Warden of the north, Lord Eddard Stark counts it a curse when King Robert bestows on him the office of the Hand. His honour weighs him down at court where a true man does what he will, not what he must … and a dead enemy is a thing of beauty.

                  The old gods have no power in the south, Stark’s family is split and there is treachery at court. Worse, the vengeance-mad heir of the deposed Dragon King has grown to maturity in exile in the Free Cities. He claims the Iron Throne.",
                  publisher: publishers[3],
                  format: "book"
  game_of_thrones.tags << tags[0]
  game_of_thrones.tags << tags[1]
  game_of_thrones.tags << tags[4]
  game_of_thrones.authors << authors[0]
  game_of_thrones.save if game_of_thrones.valid?

  the_healthy_programmer = Print.new pages: 220,
                  title: "The Healthy Programmer",
                  language: "english",
                  isbn: 9781937785314,
                  description: "To keep doing what you love, you need to maintain your own systems, not just the ones you write code for. Regular exercise and proper nutrition help you learn, remember, concentrate, and be creative—skills critical to doing your job well. Learn how to change your work habits, master exercises that make working at a computer more comfortable, and develop a plan to keep fit, healthy, and sharp for years to come.

                  This book is intended only as an informative guide for those wishing to know more about health issues. In no way is this book intended to replace, countermand, or conflict with the advice given to you by your own healthcare provider including Physician, Nurse Practitioner, Physician Assistant, Registered Dietician, and other licensed professionals",
                  publisher: publishers[4],
                  format: "book"
  the_healthy_programmer.tags << tags[2]
  the_healthy_programmer.tags << tags[8]
  the_healthy_programmer.tags << tags[9]
  the_healthy_programmer.authors << authors[1]
  the_healthy_programmer.save if the_healthy_programmer.valid?

  programming_ruby = Print.new pages: 864,
                  title: "Programming Ruby: The Pragmatic Programmers Guide",
                  language: "english",
                  isbn: 9780974514055,
                  description: "To keep doing what you love, you need to maintain your own systems, not just the ones you write code for. Regular exercise and proper nutrition help you learn, remember, concentrate, and be creative—skills critical to doing your job well. Learn how to change your work habits, master exercises that make working at a computer more comfortable, and develop a plan to keep fit, healthy, and sharp for years to come.

                                            This book is intended only as an informative guide for those wishing to know more about health issues. In no way is this book intended to replace, countermand, or conflict with the advice given to you by your own healthcare provider including Physician, Nurse Practitioner, Physician Assistant, Registered Dietician, and other licensed professionalsa",
                  publisher: publishers[4],
                  format: "book"
  programming_ruby.tags << tags[2]
  programming_ruby.tags << tags[3]
  programming_ruby.tags << tags[9]
  programming_ruby.authors << authors[2]
  programming_ruby.authors << authors[3]
  programming_ruby.authors << authors[4]
  programming_ruby.save if programming_ruby.valid?

  clash_of_kings = Print.new pages: 761,
                  title: "A Clash of Kings",
                  language: "english",
                  isbn: 9780553588489,
                  description: "Time is out of joint. The summer of peace and plenty, ten years long, is drawing to a close, and the harsh, chill winter approaches like an angry beast. Two great leaders—Lord Eddard Stark and Robert Baratheon—who held sway over an age of enforced peace are dead...victims of royal treachery. Now, from the ancient citadel of Dragonstone to the forbidding shores of Winterfell, chaos reigns, as pretenders to the Iron Throne of the Seven Kingdoms prepare to stake their claims through tempest, turmoil, and war.",
                  publisher: publishers[3],
                  format: "book"
  clash_of_kings.tags << tags[0]
  clash_of_kings.tags << tags[1]
  clash_of_kings.tags << tags[4]
  clash_of_kings.authors << authors[0]
  clash_of_kings.save if clash_of_kings.valid?

  storm_of_swords = Print.new pages: 1177,
                  title: "A Storm of Swords",
                  language: "english",
                  isbn: 9789545853104,
                  description: "Here is the third volume in George R.R. Martin's magnificent cycle of novels that includes A Game of Thrones and A Clash of Kings. Together, this series comprises a genuine masterpiece of modern fantasy, destined to stand as one of the great achievements of imaginative fiction.",
                  publisher: publishers[3],
                  format: "book"
  storm_of_swords.tags << tags[0]
  storm_of_swords.tags << tags[1]
  storm_of_swords.tags << tags[4]
  storm_of_swords.authors << authors[0]
  storm_of_swords.save if storm_of_swords.valid?

  feast_for_cows = Print.new pages: 1060,
                  title: "A Feast for Crows",
                  language: "english",
                  isbn: 9780553582024,
                  description: "With A Feast for Crows, Martin delivers the long-awaited fourth volume of the landmark series that has redefined imaginative fiction and stands as a modern masterpiece in the making.",
                  publisher: publishers[3],
                  format: "book"
  feast_for_cows.tags << tags[0]
  feast_for_cows.tags << tags[1]
  feast_for_cows.tags << tags[4]
  feast_for_cows.authors << authors[0]
  feast_for_cows.save if feast_for_cows.valid?

  dance_w_d = Print.new pages: 1016,
                  title: "A Dance With Dragons",
                  language: "english",
                  isbn: 9780553582033,
                  description: "With A Feast for Crows, Martin delivers the long-awaited fourth volume of the landmark series that has redefined imaginative fiction and stands as a modern masterpiece in the making.",
                  publisher: publishers[3],
                  format: "book"
  dance_w_d.tags << tags[0]
  dance_w_d.tags << tags[1]
  dance_w_d.tags << tags[4]
  dance_w_d.authors << authors[0]
  dance_w_d.save if dance_w_d.valid?

  witching = Print.new pages: 1207,
                  title: "The Witching Hour",
                  language: "english",
                  isbn: 9780099471424,
                  description: "On the veranda of a great New Orleans house, now faded, a mute and fragile woman sits rocking. And the witching hour begins...

                  Demonstrating once again her gift for spellbinding storytelling and the creation of legend, Anne Rice makes real for us a great dynasty of witches - a family given to poetry and incest, to murder and philosophy, a family that over the ages is itself haunted by a powerful, dangerous, and seductive being.",
                  publisher: publishers[3],
                  format: "book"
  witching.tags << tags[0]
  witching.tags << tags[1]
  witching.tags << tags[4]
  witching.authors << authors[5]
  witching.save if witching.valid?

  interview = Print.new pages: 342,
                  title: "Interview With The Vampire",
                  language: "english",
                  isbn: 9780345476876,
                  description: "Here are the confessions of a vampire. Hypnotic, shocking, and chillingly erotic, this is a novel of mesmerizing beauty and astonishing force—a story of danger and flight, of love and loss, of suspense and resolution, and of the extraordinary power of the senses. It is a novel only Anne Rice could write.",
                  publisher: publishers[5],
                  format: "book"
  interview.tags << tags[0]
  interview.tags << tags[1]
  interview.tags << tags[4]
  interview.authors << authors[5]
  interview.save if interview.valid?


  hunger = Print.new pages: 374,
                  title: "The Hunger Games",
                  language: "english",
                  isbn: 9780439023481,
                  description: "Katniss, 16, takes her sister's place in the televised annual Hunger Games, competing against Peeta, the boy who gave them bread to survive after their father died. The cruel Capitol forces each of 12 districts to submit a boy and girl 12-18, to fight to the death. Only one can survive and be rewarded. President Snow manipulates behind the scenes.",
                  publisher: publishers[6],
                  format: "book"
  hunger.tags << tags[0]
  hunger.tags << tags[1]
  hunger.tags << tags[4]
  hunger.authors << authors[6]
  hunger.save if hunger.valid?

  Print.all.each_with_index do |print, index|
    random_number = 3
    random_number = 1 if index.odd?
    random_number.times do |copy_index|
      dummy_copy = Copy.new print: print, inventory_number: 1000 + (index * 10) + copy_index
      dummy_copy.save if dummy_copy.valid?
    end
  end

  names = [
    "Georgi Dimitrov Urumov",
    "Krisian Doychinov Tashkov",
    "Nikola Kiryakov Taushanov",
    "Georgi Stefanov Gardev",
    "Filareta Veselinova Yordanova",
    "Svetlana Mariyanova Velichkova",
    "Yordan Rumenov Petrov",
  ]

  names.each_with_index do |name, index|
    three_names = name.split " "
    username = three_names[0][0].concat(three_names[1][0]).concat(three_names[2]).downcase
    dummy_user = User.new name: name,
                  email: "#{username}@uni-sofia.bg",
                  password: username,
                  password_confirmation: username

    dummy_user.save if dummy_user.valid?
  end

  admin = User.new name: "Petar Dimitrov Ivanov",
        email: "admin@admin.com",
        admin: true,
        password: "adminadmin",
        password_confirmation: "adminadmin"

  admin.save!

  users = User.all

  rec = Recommendation.new user: users[0],
                print: game_of_thrones,
                rating: 5,
                comment: 'here are about a billion reviews of this one so i doubt i have anything to add. the only thing i feel truly compelled to say is TYRION THE DWARF IS AWESOME! my God, i haven"t read a character who is so different and so enjoyable in years. many-layered and consistently surprising, hero & antihero, generous & spiteful in equal amounts, as capable of high-handed miscalculation as he is of clever deduction, brave & loyal & vindictive... just overall a superb creation. Tyrion, you are the tops! and now you"re going to be played by the studliest dwarf actor in the business. GO, TYRION, GO!'
  rec.save

  rec2 = Recommendation.new user: users[1],
                print: game_of_thrones,
                rating: 5,
                comment: "When the King comes to Winterfell, Ned Stark soon finds himself given the post of Hand to the King by King Robert. All is not well in Winterfell, however. Stark's son is gravely injured and signs point to the King's wife's family, the Lannisters. Stark will soon find out that when you play the Game of Thrones, you either win or die...

                Okay, so it's way more complicated than that but it's hard to write a teaser for an 800+ page kitten squisher like this."
  rec2.save

  rec3 = Recommendation.new user: users[0],
                print: clash_of_kings,
                rating: 5,
                comment: "WINTERFELLLLLLL!!

                obey your nerds. is what i am learning.srsly - i was never going to read this series, but once i started... it is like a drug. and - yes - i watched season two before i read this book, but i am not going to wait for seasons 3-4 to read the next one, no way, because i am hooked and I MUST KNOW! and if any one of you people spoils the third book for me, i am going to make one of those torture devices with the bucket, the rat, and the torch, and it is bye-bye stomach for you!"
  rec3.save

  rec4 = Recommendation.new user: users[4],
                print: the_healthy_programmer,
                rating: 4,
                comment: "Early-ordered beta book, so not all content is there yet, but the part that is complete is interesting and well-presented."
  rec4.save
end
