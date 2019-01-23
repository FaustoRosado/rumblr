require_relative "../models"

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