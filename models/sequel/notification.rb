class Notification < Sequel::Model
  plugin :validation_helpers
  many_to_one :user
  def validate
    validates_presence [:user_id, :message, :is_read]
    validates_type String :message
end
