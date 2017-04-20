block do
  User.create!(
    email: '1r23r@aa.com',
    password: 'faoief'
  )
end
users = User.all

5.times do 
  Wiki.create(
    title: 'this',
    body: 'that',
    private: false,
    user: users.sample
  )
end


puts "#{User.count}"
