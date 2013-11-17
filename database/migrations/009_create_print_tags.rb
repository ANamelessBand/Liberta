Sequel.migration do
  change do
    create_table(:prints_tags) do
      primary_key :id
      foreign_key :tag_id, :tags
      foreign_key :print_id, :prints
      unique [:tag_id, :print_id]
    end
  end
end
