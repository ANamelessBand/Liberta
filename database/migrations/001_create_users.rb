Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id, autoincrement: true
      Integer :faculty_number, uniq: true
      String :name, null: false
      String :email, null: false, unique: true
      Integre :authorization_level, null: false
      TrueClass :active, null: false
      constraint(:authorization_level_is_in_range) { (0..2).member? authorization_level }
    end
  end
end
