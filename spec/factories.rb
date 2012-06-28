require 'factory_girl'
require 'faker'
FactoryGirl.define do
  factory :ticket, :class => Support do
    reason { Faker::Lorem.words(3).join(" ") }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    support { Faker::Lorem.paragraph }
  end

  factory :ticket_message, :class => Support::Message do
    body { Faker::Lorem.paragraph }
  end
end