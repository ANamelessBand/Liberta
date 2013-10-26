Sequel.migration do
  change do
    create_table(:formats) do
      primary_key :id, index: true
      String :name, null: false
    end
  end
end
