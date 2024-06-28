FactoryBot.define do
  factory :customer do
    first_name { "MyString" }
    last_name { "MyString" }
    email { Faker::Internet.email }
    address { "MyString" }
  end
end
