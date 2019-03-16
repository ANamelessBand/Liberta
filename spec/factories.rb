# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Faker::Book.author }
  end

  factory :copy do
    print
    inventory_number { Faker::Number.number(4) }

    trait :loaned do
      loans { [create(:loan)] }
    end

    trait :overdue do
      loans { [create(:loan, :overdue)] }
    end
  end

  factory :loan do
    user
    copy

    trait :returned do
      time_returned { Time.now }
    end

    trait :overdue do
      time_supposed_return { Time.now - 1.days }
    end
  end

  factory :news do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end

  factory :notification do
    user
    message { Faker::Lorem.sentence }

    trait :read do
      read { true }
    end

    trait :unread do
      read { false }
    end
  end

  factory :print do
    publisher
    title { Faker::Book.title }
    language { Faker::Nation.language }
    isbn { Faker::Code.isbn }
  end

  factory :publisher do
    name { Faker::Book.publisher }
  end

  factory :recommendation do
    print
    user
  end

  factory :tag do
    name { Faker::Book.genre }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
    password_confirmation { password }

    trait :admin do
      admin { true }
    end
  end

  factory :wishlist do
    user
    print
  end
end
