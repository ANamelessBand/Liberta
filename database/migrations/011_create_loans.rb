Sequel.migration do
  change do
    create_table(:loans) do
      primary_key :id, index: true
      foreign_key :copy_id, :copies
      foreign_key :user_id, :users
      Date :date_loaned
      Date :date_supposed_return, index: true
      Date :date_returned
      end
    end
  end
