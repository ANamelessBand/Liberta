class Notification < Sequel::Model
  many_to_one :user
  
  plugin :validation_helpers
  
  def validate
    super
    validates_presence [:user_id, :message, :is_read]
  end
end
