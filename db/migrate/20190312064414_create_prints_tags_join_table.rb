# frozen_string_literal: true

class CreatePrintsTagsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :prints, :tags do |t|
      t.index :print_id
      t.index :tag_id
    end
  end
end
