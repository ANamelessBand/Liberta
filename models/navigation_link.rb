class NavigationLink
  def self.news_id() 1; end
  def self.books_id() 2; end
  attr_accessor :id
  attr_accessor :href
  attr_accessor :title
  attr_accessor :active 

  def initialize(id, href, title)
    @id = id
    @href = href
    @title = title
    @active = false
  end
end