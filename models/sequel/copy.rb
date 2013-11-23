class Copy < Sequel::Model
  many_to_one :print
  one_to_many :loans

  def take
    is_taken = true
  end

  def take!
    take
    save
  end

  def return
    is_taken = false
  end

  def return!
    self.return
    save
  end
end
