Sequel.migration do
  change do
    # Create Copies table
    create_table(:copies) do
      primary_key :id, index: true
      Integer :inventory_number, null: false
      TrueClass :is_taken, default: false, null: false
      foreign_key :print_id, :prints
    end
  end
end
