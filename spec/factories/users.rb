require 'faker'

FactoryBot.define do
  factory :user do
    full_name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
    address { Faker::Address.full_address }
    password { Faker::Internet.password }
    role { :regular }
  end

  factory :blocked_user do
    role { :blocked }
  end

  factory :admin do
    role { :admin }
  end
end
