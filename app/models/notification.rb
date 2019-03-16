# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  scope :read,   -> { where read: true }
  scope :unread, -> { where read: false }
end
