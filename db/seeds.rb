# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.delete_all
Plan.create(name: "test first", price: 10, currency: "aud", activated: true)
Plan.create(name: "test second", price: 20, currency: "aud", activated: true)
Plan.create(name: "Test Third", price: 30, currency: "aud", activated: true)
Plan.create(name: "Test Fourth", price: 40, currency: "aud", activated: true)
Plan.create(name: "Test Fifth", price: 50, currency: "aud", activated: true)
Plan.create(name: "Test Six", price: 60, currency: "aud", activated: true)

Addon.delete_all

Addon.create(name: "EBay -add-on", price: 20, currency: "aud", activated: true)
Addon.create(name: "Fashbook-Shop", price: 50, currency: "aud", activated: true)
Addon.create(name: "Website -add-on", price: 100, currency: "aud", activated: true)

Admin.delete_all
Admin.create(email: 'admin@mailinator.com', passowrd: '12345678', passowrd_confirmation: '12345678')
User.create(email: 'test@mailinator.com', passowrd: '12345678', passowrd_confirmation: '12345678', first_name: 'test', last_name: 'kumar')