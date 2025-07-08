# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }
    locked { true }
    address

    trait :admin do
      admin { true }
    end
  end
end
