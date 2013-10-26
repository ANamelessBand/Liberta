class Notification < Sequel::Model
  plugin :validation_helpers

  many_to_one :user

  def validate
    super
    validates_presence [:user_id, :message, :is_read]
  end
end
