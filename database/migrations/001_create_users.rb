Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id, index: true
      Integer :faculty_number, uniq: true, index: true
      String :name, null: false
      String :email, null: false, unique: true
      Integre :authorization_level, null: false
      TrueClass :is_active, default: true, null: false
      File :avatar
    end
  end
end
