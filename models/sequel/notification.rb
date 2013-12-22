class Notification < Sequel::Model
  plugin :validation_helpers

  many_to_one :user

  class << self
    def free_copy(user, print)
      create user:    user,
             message: "Налично е свободно копие на '#{print.title}'.",
             is_read: false
    end

    def out_of_copies(user, print)
      create user:    user,
             message: "Копията на #{print.title} са изчерпани.",
             is_read: false
    end

    def mark_read(id)
      notification = Notification.find id: id
      notification.mark_read
    end
  end

  def validate
    super
    validates_presence [:user_id, :message, :is_read]
  end

  def mark_read
    update is_read: true
  end
end
