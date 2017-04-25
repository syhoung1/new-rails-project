5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(10, 20)
  )
end
users = User.all

30.times do 
  users.sample.wikis.create!(
    title: Faker::Superhero.name,
    body: Faker::Hipster.paragraph,
    private: Faker::Boolean.boolean,
  )
end
