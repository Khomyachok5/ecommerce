# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create(title: "abc")
Category.first.products.create(title: "abc_product", description: "abc product description. It's AWESOME", price: 1567, stock: 1000)
Category.first.subcategories.create(title: "new subcategory")
User.create(email: "admin@bestshop.com", password: "12345678", is_admin: true)
User.create(email: "visitor@bestshop.com", password: "12345678")
