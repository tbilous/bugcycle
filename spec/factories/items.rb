FactoryBot.define do
  factory :item do
    title { Faker::FamilyGuy.character }
    description { Faker::FamilyGuy.quote }
  end
end
