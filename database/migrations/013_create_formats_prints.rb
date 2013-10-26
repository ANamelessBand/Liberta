Sequel.migration do
  change do
    create_table(:formats_prints) do
      primary_key :id
      foreign_key :format_id, :formats
      foreign_key :print_id, :prints
      unique [:format_id, :print_id]
    end
  end
end
