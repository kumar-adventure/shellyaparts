# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.delete_all
Plan.create(name: "test first", price: 10, currency: "aud")
Plan.create(name: "test second", price: 20, currency: "aud")
Plan.create(name: "Test Third", price: 30, currency: "aud")
Plan.create(name: "Test Fourth", price: 40, currency: "aud")
Plan.create(name: "Test Fifth", price: 50, currency: "aud")
Plan.create(name: "Test Six", price: 60, currency: "aud")