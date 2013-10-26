Copy.all.each_with_index do |copy, index|
  if index.remainder(3).zero?
    sample_number = (1..200).to_a.sample
    sample_date = Date.today - sample_number
    date_of_supposed_return = sample_date + (31..93).to_a.sample
    date_returned = nil
    if index.odd?
      date_returned = sample_date + (1..sample_number).to_a.sample
    else
      copy.is_taken = true
      copy.save
    end
    dummy_loan = Loan.new date_loaned: sample_date,
                          date_supposed_return: date_of_supposed_return,
                          date_returned: date_returned,
                          user: User.all.sample,
                          copy: copy
    dummy_loan.save
  end
end
