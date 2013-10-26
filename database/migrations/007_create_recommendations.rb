Sequel.migration do
  change do
    create_table(:recommendations) do
      primary_key :id, index: true
      foreign_key :user_id, :users
      foreign_key :print_id, :prints
      Integer :rating
      String :comment
      constraint(:rating_is_in_range) { (1..5).include? rating }
    end
  end
end
