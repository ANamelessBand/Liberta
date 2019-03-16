# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :prints

  validates_presence_of :name

  paginates_per 10
end
