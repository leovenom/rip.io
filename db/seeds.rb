# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Destroying data'

Attraction.destroy_all
Tour.destroy_all
User.destroy_all


User.create(first_name: 'user', last_name: 'one', email: email@email.com)
Attraction.create(name: 'Cemitério', address: 'Rua do conde de Redondo, 91B', description: 'really dark cemitery')


puts 'creating attractions'


puts 'finished'
