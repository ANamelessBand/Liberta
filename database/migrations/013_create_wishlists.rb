Sequel.migration do
  change do
    create_table(:wishlists) do
      primary_key :id
      foreign_key :user_id, :users
      foreign_key :print_id, :prints
      TrueClass :is_satisfied
    end
  end
end