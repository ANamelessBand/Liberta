Sequel.migration do
  up do
    #Create Prints table
    create_table(:prints) do
      Integer :id, :primary_key=>true, :auto_increment=>true, :index=>true
      Integer :pages, :null=>false
      Float :price, :null=>false
      String :name, :null=>false, :index=>true
      String :language, :null=>false
      String :isbn, :null=>false, :unique=>true, :index=>true
      String :Description, :text => true, :null=>false
    end
  end

  down do
    drop_table(:prints)
  end
end

