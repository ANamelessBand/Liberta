authors = [
            'J. J. Martin',
            'J. R. R. Talkien',
            'Terry Pratchet',
            'Ivan Vazov',
            'Hristo Botev',
            'J. K. Rowling',
            'Douglas Addams',
            'Paulo Coelho',
            'Elin Pelin',
            'Atanas Dalchev',
          ]

authors.each do |author_name|
  dummy_author = Author.new name: author_name
  dummy_author.save if dummy_author.valid?
end
