module PrintsHelpers
  def authors_html(print)
    print.authors.map { |author| to_link("/authors/#{author.id}", author.name) }.join(', ')
  end

  def return_loan(loan)
    copy = loan.copy
    loan.date_returned = Date.today
    copy.is_taken = false
    copy.save
    loan.save
  end

  def notify_copy_is_free(print)
    Wishlist.where(print: print, is_satisfied: false).each do |wish|
      Notification.create user: wish.user,
                          message: "Налично е свободно копие на '#{print.title}'.",
                          is_read: false
    end
  end

  def show_print_table(prints, ratings_last_month = false)
    @prints_collection = prints
    @ratings_last_month = ratings_last_month
    erb :'prints_table.html'
  end
end
