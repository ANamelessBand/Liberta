Sequel.migration do
  change do
    create_table(:notifications) do
      primary_key :id, autoincrement: true
      foreign_key :user_id, :users, null: false
      String :message, text: true, null: false
      TrueClass :is_read, default: false, null: false
    end
  end
end
