# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

House.create!(
  name: 'Roselands',
  category: 'Bungalow',
  description: 'A white and brown concrete building under the blue sky', photo_url: 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1267&q=80'
)

House.create!(
  name: 'Ostrich\'s Lodge',
  category: 'Ranch-Style',
  description: 'A futuristic modern wooden house fitted with glass doors and windows',
  photo_url: 'https://images.unsplash.com/photo-1591474200742-8e512e6f98f8?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=967&q=80'
)

House.create!(
  name: 'The Primeroses', 
  category: 'Ranch-Style',
  description: 'A beautiful multi-purpose Chinese house. It is suited for both a bar and a residence', 
  photo_url: 'https://images.unsplash.com/photo-1531971589569-0d9370cbe1e5?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=760&q=80'
)
House.create!(
  name: 'Sunny Lodge', 
  category: 'Semi-Detached House', 
  description: 'An urban house in a serene neighborhood. It\'s suitable for medium size family', 
  photo_url: 'https://images.unsplash.com/photo-1559329145-afaf18e3f349?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=750&q=80'
)
House.create!(
  name: 'Gray End', 
  category: 'Lakeside Vacation Cottage', 
  description: 'A wooden cabin perfectly suited for those who enjoy life with nature', 
  photo_url: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
)
