# frozen_string_literal: true

class CreateAuthorsPrintsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :authors, :prints do |t|
      t.index :author_id
      t.index :print_id
    end
  end
end
