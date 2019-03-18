# frozen_string_literal: true

class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :copy

  delegate :print, to: :copy, allow_nil: true

  after_initialize :init

  def init
    self.time_supposed_return ||= Time.now + Rails.configuration.default_loan_time
  end

  def returned?
    time_returned.present?
  end

  def unreturned?
    not returned?
  end

  def overdue?
    unreturned? && time_supposed_return < Time.now
  end

  def return!
    self.time_returned = Time.now
    save!
  end

  def extend!(duration = Rails.configuration.default_loan_time)
    self.time_supposed_return += duration
    save!
  end
end
