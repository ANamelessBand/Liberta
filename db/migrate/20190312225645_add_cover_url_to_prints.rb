# frozen_string_literal: true

class AddCoverUrlToPrints < ActiveRecord::Migration[5.2]
  def self.up
    add_column :prints, :cover_url, :string
  end

  def self.down
    remove_column :prints, :cover_url
  end
end
