FactoryBot.define do
  factory :category do
    title { Faker::RickAndMorty.character + (1..1000).to_a.sample(2).to_s }
  end
end
