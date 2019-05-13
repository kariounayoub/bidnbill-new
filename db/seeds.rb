# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Bid.destroy_all
Bill.destroy_all
User.destroy_all
Account.destroy_all

account = Account.create!(company: 'EDF')

client = User.create!(email: 'majid@gmail.com', password: '123456', first_name: 'Majid', last_name: 'Jaidi', user_type: 'client')
provider = User.create!(email: 'ayoub@gmail.com', password: '123456', first_name: 'Ayoub', last_name: 'Kairoun', user_type: 'provider', account: account)

Category.destroy_all
category1 = Category.create!(name: 'Electricité')
category2 = Category.create!(name: 'Gaz')
category3 = Category.create!(name: 'Electricité et Gaz')
category4 = Category.create!(name: 'Téléphonie')
category5 = Category.create!(name: 'Internet')

AccountCategory.create!(account: account, category: category1)
AccountCategory.create!(account: account, category: category2)
AccountCategory.create!(account: account, category: category3)


bill1 = Bill.create!(user_id: client.id, current_provider: 'EDF', address: '18 rue miolis', category: category1, city: 'Paris', zip_code: '75001', consumption: '200', price: '50')
bill2 = Bill.create!(user_id: client.id, current_provider: 'Total Direct Energie', address: '18 rue miolis', category: category1, city: 'Paris', zip_code: '75001', consumption: '250', price: '60')


Bid.create!(bill: bill1, user_id: provider.id, content: 'some descriptive text', price: 45)
Bid.create!(bill: bill1, user_id: provider.id, content: 'some descriptive text2', price: 47)
Bid.create!(bill: bill2, user_id: provider.id, content: 'some descriptive text4', price: 52)
