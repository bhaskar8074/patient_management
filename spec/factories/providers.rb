FactoryBot.define do
  factory :provider do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "provider#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
