require 'lorem_ipsum_amet'
# require_relative "../models"

User.create(
  email: 'fausto@gmail.com',
  password: 'password',
  firstname: 'Fausto',
  lastname: 'R',
  birthday: '09/07/1980'
)

User.create(
  email: 'samantha@gmail.com',
  password: 'password',
  firstname: 'Samantha',
  lastname: 'SR',
  birthday: '09/25/1980'
)

User.create(
  email: 'johndoe@gmail.com',
  password: 'password',
  firstname: 'John',
  lastname: 'D',
  birthday: '01/01/2000'
)

1..80).each do |_|
  Post.create(
    title: LoremIpsum.w(rand(1..4)),
    content: LoremIpsum.random(paragraphs: rand(1..3)),
    user_id: rand(1..3),
    image_url: 'media/filler.jpg',
    datetime: Time.now
  )
end