# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


client = User.create(email: 'majid@gmail.com', password: '123456', first_name: 'Majid', last_name: 'Jaidi', user_type: 'client')
provider = User.create(email: 'ayoub@gmail.com', password: '123456', first_name: 'Ayoub', last_name: 'Kairoun', user_type: 'provider')
