# frozen_string_literal: true

class CreatePrints < ActiveRecord::Migration[5.2]
  def change
    create_table :prints do |t|
      t.string :title, null: false
      t.string :language, null: false
      t.string :format
      t.string :isbn
      t.text :description
      t.integer :pages

      t.references :publisher

      t.timestamps
    end
  end
end
