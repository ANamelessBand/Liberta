# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # devise :recoverable
  # devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :recommendations, dependent: :destroy
  has_many :notifications,   dependent: :destroy
  has_many :wishlists,       dependent: :destroy
  has_many :loans, -> { order(time_loaned: :desc) }, dependent: :destroy

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.token = auth.credentials.token
  #     user.expires = auth.credentials.expires
  #     user.expires_at = auth.credentials.expires_at
  #     user.refresh_token = auth.credentials.refresh_token
  #   end
  # end

  def name_or_email
    if name.present?
      name
    else
      email
    end
  end

  def wish?(print)
    wish_for(print).present?
  end

  def wish_for(print)
    wishlists.find { |w| w.print == print }
  end

  def loaned_prints
    loans.map(&:print)
  end

  def has_recommended?(print)
    not recommendations.find { |r| r.print == print }.nil?
  end

  def unread_notifications?
    notifications.unread.any?
  end

  def notify!(message)
    Notification.create(user: self, message: message)
  end

  def mark_notifications_as_read!
    notifications.each(&:read!)
  end
end
