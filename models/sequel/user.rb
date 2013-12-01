class User < Sequel::Model
  plugin :validation_helpers

  one_to_many :notifications
  one_to_many :recommendations
  one_to_many :loans
  one_to_many :wishlists

  def validate
    super
    validates_presence [
                         :username,
                         :name,
                         :faculty_number,
                         :email,
                         :authorization_level,
                         :is_active,
                       ]

    validates_unique :username, :faculty_number, :email

    validates_includes [0, 1, 2], :authorization_level
  end

  class << self
    def wishing(print)
      # TODO: consider using join.
      all.select { |user| user.wish? print }
    end
  end

  def active?
    is_active
  end

  def activate
    update is_active: true
  end

  def deactivate
    update is_active: false
  end

  def read_prints
    loans_dataset.exclude(date_returned: nil).reverse_order :date_returned, :id
  end

  def last_recommendations
    recommendations_dataset.reverse_order :date_of_comment, :id
  end

  def wished_prints
    # TODO: consider using join.
    wishlists_dataset.where(is_satisfied: false).reverse_order(:id).map &:print
  end

  def wish?(print)
    wishlists_dataset.where(print_id: print.id, is_satisfied: false)
    .count.nonzero?
  end

  def current_loans
    loans_dataset.where(date_returned: nil).reverse_order :id
  end

  def unread_notifications
    notifications_dataset.where(is_read: false).reverse_order :id
  end

  def unread_notifications?
    unread_notifications.count.nonzero?
  end

  def satisfy_wish(print)
    wishlists_dataset.where(print_id: print.id).each do |user_wish|
      user_wish.satisfy
    end
  end

  def administrator?
    authorization_level.zero?
  end

  def read_notification(notification_id)
    notification = notifications_dataset.find id: notification_id
    notification.read if notification
  end
end
