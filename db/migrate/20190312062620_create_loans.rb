# frozen_string_literal: true

class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.datetime :time_loaned
      t.datetime :time_supposed_return
      t.datetime :time_returned

      t.references :copy
      t.references :user
    end
  end
end
