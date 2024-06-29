# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

customer1 = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', address: '1234 Random Street')
customer2 = Customer.create!(first_name: 'Jane', last_name: 'Doe', email: 'janedoe@email.com', address: '2345 Random Street')
customer3 = Customer.create!(first_name: 'Ron', last_name: 'Burgundy', email: 'ronb@email.com', address: '3456 Random Street')
customer4 = Customer.create!(first_name: 'Master', last_name: 'Chief', email: 'masterchief@email.com', address: 'Reach New Reach City')
customer5 = Customer.create!(first_name: 'Doom', last_name: 'Guy', email: 'notmasterchief@email.com', address: 'Down Under')

subscription1 = Subscription.create!(title: 'Expensive Tea', price: '10000', status: 'enabled', frequency: '1')
subscription2 = Subscription.create!(title: 'Least Expensive Tea', price: '100', status: 'disabled', frequency: '12')
subscription3 = Subscription.create!(title: "It's Tea", price: '5000', status: 'enabled', frequency: '3')
subscription4 = Subscription.create!(title: 'A Lot Of Tea', price: '9001', status: 'enabled', frequency: '9')
subscription5 = Subscription.create!(title: 'More Tea', price: '500', status: 'disabled', frequency: '1')

CustomerSubscription.create!(customer_id: customer1.id, subscription_id: subscription1.id)
CustomerSubscription.create!(customer_id: customer1.id, subscription_id: subscription2.id)
CustomerSubscription.create!(customer_id: customer1.id, subscription_id: subscription4.id, status: 'cancelled')
CustomerSubscription.create!(customer_id: customer1.id, subscription_id: subscription5.id)

CustomerSubscription.create!(customer_id: customer2.id, subscription_id: subscription1.id, status: 'cancelled')

CustomerSubscription.create!(customer_id: customer3.id, subscription_id: subscription1.id, status: 'cancelled')
CustomerSubscription.create!(customer_id: customer3.id, subscription_id: subscription1.id)
CustomerSubscription.create!(customer_id: customer3.id, subscription_id: subscription2.id, status: 'cancelled')
CustomerSubscription.create!(customer_id: customer3.id, subscription_id: subscription3.id, status: 'cancelled')
CustomerSubscription.create!(customer_id: customer3.id, subscription_id: subscription4.id, status: 'cancelled')
CustomerSubscription.create!(customer_id: customer3.id, subscription_id: subscription5.id, status: 'cancelled')
