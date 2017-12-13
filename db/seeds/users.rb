5.times do |n|
  User.create!(
    email: "pierre#{n}@michaux.com",
    password: 'progenitor'
  )
end
