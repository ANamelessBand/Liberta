Sequel.migration do
  up do
    create_join_table(:print_id=>:prints, :tag_id=>:tags)
  end
  
  down do
    drop_table(:tags_prints)
  end
end
