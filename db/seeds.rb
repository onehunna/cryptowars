# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Refreshing/Creating all assets'
AssetRefreshWorker.new.perform

puts 'Creating test Index "The Fund"'
i = Index.new
i.name = 'The Fund'
i.codes = ['BTC', 'LTC', 'LSK']
i.user = User.new(name: 'Ya Boi', email: 'itsyaboi@gmail.com')
i.save
