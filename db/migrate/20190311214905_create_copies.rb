# frozen_string_literal: true

class CreateCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :copies do |t|
      t.integer :inventory_number, null: false

      t.references :print, null: false

      t.timestamps
    end
  end
end
