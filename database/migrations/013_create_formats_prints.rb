Sequel.migration do
  up do
    create_join_table(:print_id=>:prints, :format_id=>:formats)
  end
  
  down do
    drop_table(:formats_prints)
  end
end
