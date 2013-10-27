module PrintsHelpers
  def authors_html(print)
    print.authors.map { |author| to_link("/authors/#{author.id}", author.name) }.join(', ')
  end
end
