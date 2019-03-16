# frozen_string_literal: true

class Publisher < ApplicationRecord
  has_many :prints

  validates_presence_of :name

  paginates_per 10
end
