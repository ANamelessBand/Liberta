Sequel.migration do
  change do
    create_table(:authors_prints) do
      primary_key :id
      foreign_key :author_id, :authors
      foreign_key :print_id, :prints
      unique [:author_id, :print_id]
    end
  end
end
