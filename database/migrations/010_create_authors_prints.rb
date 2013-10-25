Sequel.migration do
  up do
    #Creating a many-to-many table for prints <-> authors
    create_join_table(:prints_id=>:prints, :authors_id=>:authors)
  end

  down do
    drop_table(authors_prints)
  end
end
