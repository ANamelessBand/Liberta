# frozen_string_literal: true

class Copy < ApplicationRecord
  has_many :loans, -> { order("time_loaned DESC") }, dependent: :destroy

  belongs_to :print

  validates_presence_of :print_id
  validates :inventory_number, presence: true, numericality: true

  def taken?
    loans.any? { |loan| loan.time_returned.nil? }
  end

  def free?
    not taken?
  end

  def current_loan
    return nil unless taken?

    loans.find { |loan| loan.time_returned.nil? }
  end
end
