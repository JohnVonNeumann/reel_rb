# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Example User",
             email: "example@reelapp.org",
             password:              "foobaruser123",
             password_confirmation: "foobaruser123",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@reelapp.org"
  password = "password123"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
