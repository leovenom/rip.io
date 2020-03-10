# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "open-uri"

puts 'Destroying data'

Personality.destroy_all
Attraction.destroy_all
Tour.destroy_all
User.destroy_all

puts 'creating user'

user = User.create(first_name: 'user', last_name: 'one', email: 'email@email.com', password: '123456')

puts 'creating attractions'

nomes = %w(Cemitery Reap Mausoleum Hospital Catacomb Casket CoronaVirus Javascript)

address = %W([
  {
    "address": "Rua de Arroios 85",
    "city": "Lisboa",
    "Country": "portugal"
  },
  {
    "address": "Conde de Baependi 79",
    "city": "Rio de Janeiro",
    "Country": "Brasil"
  },
  {
    "address": "Rua dom silverio 86",
    "city": "Mariana",
    "Country": "Brasil"
  },
  {
    "address": "Rua conde do redondo 91",
    "city": "Lisboa",
    "Country": "Portugal"}
  ])

10.times do



 url = 'https://baconipsum.com/api/?type=meat-and-filler'
 user_serialized = open(url).read
 bacon = JSON.parse(user_serialized)

file = URI.open('https://placeimg.com/640/480/any')
attraction = Attraction.new(name: nomes.sample,
  address: address.sample,
  description: bacon.first.partition(" ").first,
  text: bacon.first
  user: user
attraction.photos.attach(io: file, filename: 'picsum.jpg', content_type: 'image/jpg')


attraction.save
end

puts 'done'
