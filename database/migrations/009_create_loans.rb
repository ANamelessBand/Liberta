Sequel.migration do
  change do
    create_table(:loans) do
      primary_key :id, autoincrement: true
      foreign_key :copie_id, :copies
      foreign_key :user_id, :users
      Date :date_loaned
      Date :date_supposed_return
      Date :date_returned
      end
    end
  end