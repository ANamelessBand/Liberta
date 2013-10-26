Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id, index: true
      String :username, size: 32, unique: true, null: false
      Integer :faculty_number, unique: true, index: true
      String :name, null: false
      String :email, null: false, unique: true
      Integer :authorization_level, null: false
      TrueClass :is_active, default: true, null: false
      File :avatar
    end
  end
end
