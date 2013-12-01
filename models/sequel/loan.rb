class Loan < Sequel::Model
  plugin :validation_helpers

  many_to_one :copy
  many_to_one :user

  def validate
    super
    validates_presence [:date_loaned, :date_supposed_return]
  end

  def current?
    date_returned.nil?
  end

  def returned?
    !current?
  end

  def return
    update date_returned: Date.today
    copy.return
  end

  class << self
    def add(user, copy)
      create date_loaned: Date.today,
             date_supposed_return: Date.today + 31,
             copy: copy,
             user: user
    end
  end
end
