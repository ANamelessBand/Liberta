# frozen_string_literal: true

class CreatePublishers < ActiveRecord::Migration[5.2]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
    end
  end
end
