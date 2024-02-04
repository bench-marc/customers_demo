# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    housenumber { Faker::Number.digit }
    zip { Faker::Address.zip_code }
    city { Faker::Address.city }
  end
end
