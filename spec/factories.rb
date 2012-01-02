require 'factory_girl'
require 'faker'
FactoryGirl.define do
  factory :ticket, :class => Support do
    reason { Faker::Lorem.words(3) }
    name { Faker::Address.name }
    email { Faker::Internet.email }
    support { Faker::Lorem.paragraph }
  end
end