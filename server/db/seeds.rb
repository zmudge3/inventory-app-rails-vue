# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

plastic_tote = Container.create(name: "Plastic Tote")
bookshelf = Container.create(name: "Bookshelf")

Item.create(name: "Bathroom Cleaner", quantity: 1, container_id: plastic_tote.id)
Item.create(name: "Scrubbing Sponge", quantity: 3, container_id: plastic_tote.id)
Item.create(name: "The C Programming Language", quantity: 1, container_id: bookshelf.id)
Item.create(name: "Introduction to Algorithms", quantity: 1, container_id: bookshelf.id)
