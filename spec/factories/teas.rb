FactoryBot.define do
  factory :tea do
    title { "MyString" }
    description { "MyString" }
    temperature { 150..190 }
    brew_time { 1..5 }
  end
end
