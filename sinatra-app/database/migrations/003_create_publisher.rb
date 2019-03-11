Sequel.migration do
  change do
    create_table(:publishers) do
      primary_key :id, index: true
      String :name, null: false
    end
  end
end
