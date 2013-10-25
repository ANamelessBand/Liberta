Sequel.migration do
  up do
    create_table(:publishers) do
      Integer :id, :primary_key=>true
      String :name, :null=>false
    end
  end

  down do
    drop_table(:publishers)
  end
end
