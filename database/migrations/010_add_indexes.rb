Sequel.migration do
  up do
    alter_table(:authors) do
      add_index :name
    end
    alter_table(:publishers) do
      add_index :name
    end
  end

  down do
    alter_table(:authors) do
      drop_index
    end
    alter_table(:publishers) do
      drop_index
    end
  end
end