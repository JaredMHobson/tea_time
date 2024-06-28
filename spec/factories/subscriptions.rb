FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { 1..2000 }
    status { 0..1 }
    frequency { 1..6 }
  end
end
