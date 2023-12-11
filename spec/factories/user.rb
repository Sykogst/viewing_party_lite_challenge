FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 5, max_length: 10) }
    password_confirmation { password }
  end
end