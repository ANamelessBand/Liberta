# frozen_string_literal: true

class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :copy

  delegate :print, to: :copy, allow_nil: true
end
