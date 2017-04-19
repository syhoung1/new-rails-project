5.times do 
  Wiki.create(
    title: 'this',
    body: 'that',
    private: false,
    user: User.find(1)
  )
end
