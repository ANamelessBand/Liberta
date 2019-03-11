titles = [
           'Important!!!',
           'Breaking news! Book worms have attacked!',
           'NeNowinite - oficialen sponsor na HackFmi',
           'Manekenki poludqha po nowata kniga na Paulo Coehlo',
           'Twilight 7 - Return of the fairies'
         ]

contents = [
            "The library has bought some new books! Go on and read them!",

            "Do not forget about tommorows special event! Come on and read with us!",

            "The new Terry Pratchet's book - Raising Steam will come out off print in just two weeks!",

            "Pisna mi ot toq jivot beeee :D",
          ]

dates = ["12.10.2013", "11.10.2013", "13.10.2013"]

titles.each do |new_title|
  dummy_news = News.new title: new_title,
                        content: contents.sample,
                        date_of_publication: dates.sample
  dummy_news.save if dummy_news.valid?
end