# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create(title: "Cars")
Category.first.products.create(title: "Car seat", description: "Car seat product description. It's AWESOME", price: 1567, stock: 1000)
Category.first.subcategories.create(title: "Car accessories")
User.create(email: "admin@teamcommerce.com", password: "12345678", is_admin: true)
User.create(email: "visitor@teamcommerce.com", password: "12345678")
Product.create(title: "abc product", description: "description for abc product", price: "123,98", slug: "abc", category_id: nil, stock: 100)
