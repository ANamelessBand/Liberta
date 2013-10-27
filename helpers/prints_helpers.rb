module PrintsHelpers
  def authors_html(print)
    print.authors.map { |author| to_link("/authors/#{author.id}", author.name) }.join(', ')
  end

  def show_print_table(prints, ratings_last_month = false, to_wishlist = true)
    @prints_collection = prints
    @ratings_last_month = ratings_last_month
    @to_wishlist = to_wishlist
    erb :'prints_table.html'
  end
end
