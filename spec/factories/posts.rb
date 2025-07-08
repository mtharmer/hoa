# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    message { Faker::Quote.yoda }
    user
  end
end
