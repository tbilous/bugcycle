Category.all.each do
  25.times do
    title = Faker::RickAndMorty.character + (1..1000).to_a.sample(2).join.to_s
    descr = Faker::Food.ingredient + (1..1000).to_a.sample(2).join.to_s

    Item.create!(
      title: title,
      description: descr,
      category_id: Category.all.sample.id,
      picture: URI.parse('https://dummyimage.com/300x200/000/fff.jpg'),
      user_id: User.all.sample.id
    )
  end
end
