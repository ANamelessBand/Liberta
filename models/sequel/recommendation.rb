class Recommendation < Sequel::Model
  plugin :validation_helpers

  many_to_one :user
  many_to_one :print

  def validate
    super
    validates_presence [:user_id, :print_id, :rating, :date_of_comment]
    validates_includes [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5], :rating
  end

  class << self
    def add(user, print, rating, comment)
      recommendation = find user: user, print: print

      if recommendation
        recommendation.update rating: rating,
                              comment: comment,
                              date_of_comment: date
      else
        create rating: rating,
               comment: comment,
               date_of_comment: Date.today,
               user: user,
               print: print
      end
    end
  end
end
