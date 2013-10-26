Sequel.migration do
  change do
    create_table(:recommendations) do
      primary_key :id, index: true
      foreign_key :user_id, :users
      foreign_key :print_id, :prints
      Integer :rating
      String :comment
    end
  end
end
