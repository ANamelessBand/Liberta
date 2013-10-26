titles = [
           'Important!!!',
           'Book worms have attacked !',
           'NeNowinite - oficialen sponsor na HackFmi',
           'Manekenki poludqha po nowata kniga na Paulo Choelo',
           'Twilight 7 - Return of the faries',
          ]

contents = [
            "The library has bought some new books! Go on and read them!",

            "Do not forget about tommorows special event! Come on and read with us!",

            "The new Terry Pratchet's book - Raising Steam will come out off print in just two weeks!",

            "Pisna mi ot toq jivot beeee :D",
          ]

date = "12.10.2013"

titles.each do |new_title|
  dummy_news = News.new title: new_title, 
                        content: contents.sample,
                        date_of_publication: date
  dummy_news.save if dummy_news.valid?
end