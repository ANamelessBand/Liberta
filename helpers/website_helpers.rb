module Liberta
  module WebsiteHelpers
    def login(username, password)
      user = User.find username: username

      # TODO: Implement authorization logic here
      session[:user] = user.id if user
    end

    def logout
      session[:user] = nil
    end

    def add_news(title, content)
      date = Date.today
      news = News.new title: title, content: content, date_of_publication: date

      if news.valid?
        news.save
      else
        # TODO: add validation logic here
      end
    end
  end
end
