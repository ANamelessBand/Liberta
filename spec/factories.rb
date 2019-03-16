# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Faker::Book.author }
  end

  factory :copy do
    print
    inventory_number { Faker::Number.number(4) }
  end

  factory :loan do
    user
    copy
  end

  factory :news do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end

  factory :notification do
    user
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
  end

  factory :wishlist do
  end
end
