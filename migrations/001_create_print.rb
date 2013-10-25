Sequel.migration do
  up do
    #Create Prints table
    create_table(:prints) do
      Integer :print_id, :primary_key=>true, :auto_increment=>true
      String :name, :null=>false
      String :language, :null=>false
      String :ISBN, :null=>false, :unique=>true
      String :Description, :text => true, :null=>false
    end
  end

  down do
    drop_table(:prints)
  end
end

