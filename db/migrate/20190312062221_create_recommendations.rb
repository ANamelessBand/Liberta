# frozen_string_literal: true

class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.string :comment
      t.float :rating, default: 0

      t.references :user, null: false
      t.references :print, null: false

      t.timestamps
    end
  end
end
