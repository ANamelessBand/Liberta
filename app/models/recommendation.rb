# frozen_string_literal: true

class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :print

  validates_presence_of :user_id
  validates :print_id, presence: true, uniqueness: { scope: :user_id }
end
