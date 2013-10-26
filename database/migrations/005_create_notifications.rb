Sequel.migration do
  change do
    create_table(:notifications) do
      primary_key :id, index: true
      foreign_key :user_id, :users
      String :message, text: true, null: false
      TrueClass :is_read, default: false, null: false
    end
  end
end
