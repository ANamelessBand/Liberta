Sequel.migration do
  change do
    create_table(:recommendations) do
      primary_key :id, index: true
      foreign_key :user_id, :users
      foreign_key :print_id, :prints
      Float :rating
      String :comment
      Date :date_of_comment, null: false
    end
  end
end
