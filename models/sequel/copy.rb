class Copy < Sequel::Model
  many_to_one :print
  one_to_many :loans

  def take
    update is_taken: true
  end

  def return
    update is_taken: false
  end

  def taken?
    is_taken
  end

  def free?
    !is_taken
  end

  def current_loan
    loans_dataset.where(date_returned: nil).first
  end

  def last_loans
    loans_dataset.reverse_order :date_loaned, :id
  end
end
