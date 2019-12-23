# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'deleting data'
Bid.destroy_all
Bill.destroy_all
User.destroy_all
Account.destroy_all
Category.destroy_all
puts 'delete complted'
puts ''

puts 'creating admin'

User.create(email: 'admin@admin.com', password: '123456', admin: true)

puts 'creating data'
account1 = Account.create!(company: 'EDF', number_users_allowed: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eget aliquet quam. Nam vel dolor at est sagittis sodales. Integer eleifend libero non eros facilisis rhoncus. Suspendisse ac sagittis neque. Maecenas nec lacus vestibulum, interdum erat ullamcorper, eleifend risus. Proin vel nisl accumsan, posuere justo et, sodales tellus. Sed porta porttitor euismod. Sed dictum tellus nunc, quis vehicula metus faucibus ac. Suspendisse potenti. Nam fringilla ligula in posuere feugiat. Pellentesque a erat et ante elementum euismod. Phasellus a mi sed ex mollis pretium eget ut est. Mauris vitae blandit diam, a eleifend justo. Aenean tincidunt diam at lorem sollicitudin, sed vehicula ante facilisis.
  ", address: "18 rue miolis, Paris", city: 'Paris', country: "France", post_code: '75015')
account2 = Account.create!(company: 'Total Direct Energie', number_users_allowed: 3)

client = User.create!(email: 'majid@gmail.com', password: '123456', first_name: 'Majid', last_name: 'Jaidi', user_type: 'client')
client2 = User.create!(email: 'ab@gmail.com', password: '123456', first_name: 'Ayoub', last_name: 'Karioun', user_type: 'client')
provider1 = User.create!(email: 'ayoub@gmail.com', password: '123456', first_name: 'Ayoub', last_name: 'Kairoun', user_type: 'provider', account: account1, account_admin: true)
provider2 = User.create!(email: 'mj@gmail.com', password: '123456', first_name: 'Majid', last_name: 'Jaidi', user_type: 'provider', account: account2)
provider3 = User.create!(email: 'maj@gmail.com', password: '123456', first_name: 'Majid', last_name: 'Jaidi', user_type: 'provider', account: account1)

category1 = Category.create!(name: 'Electricité')
category2 = Category.create!(name: 'Gaz')
category3 = Category.create!(name: 'Electricité et Gaz')
category4 = Category.create!(name: 'Téléphonie')
category5 = Category.create!(name: 'Internet')

AccountCategory.create!(account: account1, category: category1)
AccountCategory.create!(account: account2, category: category1)
AccountCategory.create!(account: account1, category: category2)
AccountCategory.create!(account: account1, category: category3)


bill1 = Bill.create!(user_id: client.id, current_provider: 'EDF', address: '18 rue miolis, Paris', category: category1, city: 'Paris', zip_code: '75001', consumption: '200', price: '50', payment_frequency: 'mensuelle', energie_verte: true, pdl: '0413433')
bill2 = Bill.create!(user_id: client.id, current_provider: 'Total Direct Energie', address: '18 rue miolis, Paris', category: category1, city: 'Paris', zip_code: '75001', consumption: '250', price: '60', payment_frequency: 'mensuelle', pdl: '0413433')
bill3 = Bill.create!(user_id: client2.id, current_provider: 'Total Direct Energie', address: 'Casablanca', category: category1, city: 'Casablanca', zip_code: '75001', consumption: '200', price: '50', payment_frequency: 'mensuelle', pdl: '0413433')
bill4 = Bill.create!(user_id: client2.id, current_provider: 'Edf', address: 'Casablanca', category: category1, city: 'Casablanca', zip_code: '75001', consumption: '200', price: '70', payment_frequency: 'mensuelle', energie_verte: true, pdl: '0413433')


bid1 = Bid.create!(bill: bill1, user_id: provider1.id, content: 'some descriptive text', price: 45)
bid2 = Bid.create!(bill: bill1, user_id: provider2.id, content: 'some descriptive text2', price: 47)
bid3 = Bid.create!(bill: bill2, user_id: provider1.id, content: 'some descriptive text4', price: 52)
bid4 = Bid.create!(bill: bill2, user_id: provider2.id, content: 'some descriptive text4', price: 54)
bid5 = Bid.create!(bill: bill3, user_id: provider2.id, content: 'some descriptive text5', price: 44)
bid6 = Bid.create!(bill: bill4, user_id: provider3.id, content: 'some descriptive text5', price: 49)

bid3.status = 'accépté'
bid3.client_status = 'Nouveau'
bid3.save

bid4.status = 'refusé'
bid4.save

bill2.is_open = false
bill2.save
puts 'seed completed'
