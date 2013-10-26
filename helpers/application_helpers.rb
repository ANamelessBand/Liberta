module ApplicationHelpers
  def set_active_navigation_link(active_id)
    self.navigation_links = [NavigationLink.new(NavigationLink.news_id, "/news", "Новини"),
                        NavigationLink.new(NavigationLink.books_id, "/books", "Книги")]
    self.navigation_links.each { |link| link.active = link.id == active_id }
  end
end