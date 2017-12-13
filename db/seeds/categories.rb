5.times do
  title = Faker::RickAndMorty.character + (1..1000).to_a.sample(2).to_s

  Category.create!(
    title: title,
    user_id: User.all.sample.id
  )
end
