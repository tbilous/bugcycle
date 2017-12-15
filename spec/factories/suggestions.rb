FactoryBot.define do
  factory :suggestion do
    title { Faker::FamilyGuy.character + (1..1000).to_a.sample(2).join.to_s }
    description { Faker::FamilyGuy.quote + (1..1000).to_a.sample(2).join.to_s }
    picture do
      Rack::Test::UploadedFile
        .new("#{Rails.root}/spec/support/for_upload/other_picture.png", 'image/png')
    end
  end
end
