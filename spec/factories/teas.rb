FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.sentence(word_count: 10) }
    temperature { Faker::Number.between(from: 150, to: 190) }
    brew_time { Faker::Number.between(from: 1, to: 5) }
  end
end
