# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id

  scope :read,   -> { where read: true }
  scope :unread, -> { where read: false }

  def read!
    self.read = true
    save
  end
end
