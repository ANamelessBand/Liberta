Sequel.migration do
  change do
    #Create Prints table
    create_table(:prints) do
      primary_key :id, index: true
      Integer :pages, null: false
      Date :date_added, null: false
      Float :price, null: false
      String :tittle, null: false, index: true
      String :language, null: false
      String :isbn, null: false, unique: true, index: true
      String :description, text: true, null: false
      File :cover
      TrueClass :is_loanable, default: true, null: false
      foreign_key :publisher_id, :publishers, null: false
      foreign_key :format_id, :formats, null: false
    end
  end
end

