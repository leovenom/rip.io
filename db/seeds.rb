# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "open-uri"

puts 'Destroying data'

Attraction.destroy_all
Tour.destroy_all
User.destroy_all

puts 'creating user'

user = User.create(first_name: 'user', last_name: 'one', email: 'email@email.com', password: '123456')

puts 'creating attractions'

file = URI.open('https://nit.pt/wp-content/uploads/2019/01/2fe6766a6b2f487e07c03af228aca558-754x394.jpg')
attraction = Attraction.new(name: 'Cemitério',
  address: 'Praça São João Bosco 568, Lisboa',
  description: 'really dark cemitery',
  text: "Breathtaking mausoleums dating back to the 1800's. Fascinating tour taken with Free Walking Tour guide. Very knowledgeable and quirky stories that admittedly are likely folklore. Highly recommend visiting this attraction in desirable Recoleta. Tourist traps located all around this famous location, but worth the hassle. We were there when a sudden monsoon hit, which made for some exciting preamble to the tour.",
  user: user)
attraction.photo.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')

attraction.save

puts 'done'
