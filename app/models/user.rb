# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recommendations, dependent: :destroy
  has_many :notifications,   dependent: :destroy
  has_many :wishlists,       dependent: :destroy
  has_many :loans,           dependent: :destroy

  def unread_notifications?
    notifications.unread.any?
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
end
