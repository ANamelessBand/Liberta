# frozen_string_literal: true

class News < ApplicationRecord
  validates_presence_of :title, :content
end
