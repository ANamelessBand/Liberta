Sequel.migration do
  change do
    create_table(:news) do
      primary_key :id, index: true
      String :title, null: false
      String :content, text: true, null: false
      Date :date_of_publication, null: false
    end
  end
end
