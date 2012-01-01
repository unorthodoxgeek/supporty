require 'factory_girl'
FactoryGirl.define do
  factory :ticket, :class => Support do
    reason { Faker::Lorem.words(3) }
    string { Faker::Address.name }
    email { Faker::Internet.email }
    text { Faker::Lorem.paragraph }
  end
end