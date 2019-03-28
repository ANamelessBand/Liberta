# frozen_string_literal: true

module GeneralHelpers
  def google_print
    double(:google_print,
      title: Faker::Book.title,
      isbn: Faker::Code.isbn,
      isbn_13: Faker::Code.isbn,
      publisher: Faker::Book.publisher,
      description: Faker::Lorem.paragraph,
      page_count: Faker::Number.within(1..1000),
      language: ["en", "bg", "fr"].sample,
      print_type: ["book", "audiobook", "magazine"].sample,
      authors_array: (1..3).to_a.map { Faker::Book.author },
      categories: (1..5).to_a.map { Faker::Book.genre }.join(","),
      image_link: Faker::Internet.url
    )
  end
end
