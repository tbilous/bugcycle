FactoryBot.define do
  factory :item do
    title { Faker::FamilyGuy.character + (1..1000).to_a.sample(2).to_s }
    description { Faker::FamilyGuy.quote }
  end
end
