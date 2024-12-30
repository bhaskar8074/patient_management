FactoryBot.define do
  factory :patient do
    provider
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "patient#{n}@example.com" }
    date_of_birth { 30.years.ago }
    next_appointment_date { 1.week.from_now }
  end
end
