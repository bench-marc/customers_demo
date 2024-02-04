# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    username { Faker::Internet.username }
    firstname { Faker::Name.first_name }
    email { Faker::Internet.email }
    lastname { Faker::Name.last_name }
    birthdate { Faker::Date.birthday }
    address { build(:address) }
  end
end
