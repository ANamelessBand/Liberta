# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :message, null: false
      t.boolean :read, default: false

      t.references :user, null: false

      t.timestamps
    end
  end
end
