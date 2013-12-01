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

    def read_notification(notification_id)
      notification = Notification.find id: notification_id
      notification.read
    end

    def get_author(author_id)
      Author.find id: author_id
    end

    def get_publisher(publisher_id)
      Publisher.find id: publisher_id
    end
  end
end
