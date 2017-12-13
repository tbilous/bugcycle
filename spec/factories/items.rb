FactoryBot.define do
  factory :item do
    title { Faker::FamilyGuy.character + (1..1000).to_a.sample(2).to_s }
    description { Faker::FamilyGuy.quote }
    picture do
      Rack::Test::UploadedFile
        .new("#{Rails.root}/spec/support/for_upload/no_picture.png", 'image/png')
    end
  end
end
