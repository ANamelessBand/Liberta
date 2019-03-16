# frozen_string_literal: true

class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :copy

  delegate :print, to: :copy, allow_nil: true

  def returned?
    time_returned.present?
  end

  def return!
    self.time_returned = Time.now
    save!
  end

  def extend!(duration = 7.days)
    self.time_supposed_return += duration
    save!
  end
end
