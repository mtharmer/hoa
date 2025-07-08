# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    message { Faker::Lorem.sentence }
    post
    user
  end
end
