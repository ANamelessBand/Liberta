Sequel.migration do
  up do
    create_table(:authors) do
      Integer :id, :primary_key=>true
      String :name, :null=>false
    end
  end

  down do
    drop_table(:authors)
  end
end
