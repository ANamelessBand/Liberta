class NavigationLink
  def self.news_id() 1; end
  def self.prints_id() 2; end
  def self.most_liked_id() 3; end
  def self.users_id() 4; end

  attr_reader :id
  attr_reader :href
  attr_reader :title
  attr_accessor :active

  def requires_logged?
    @requires_logged
  end

  def requires_admin?
    @requires_admin
  end

  def initialize(id, href, title, requires_logged = false, requires_admin = false)
    @id = id
    @href = href
    @title = title
    @requires_logged = requires_logged
    @requires_admin = requires_admin
    @active = false
  end
end
