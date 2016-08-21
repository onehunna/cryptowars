# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Asset.any?
  puts 'Refreshing/Creating all assets'
  AssetRefreshWorker.new.perform
end

puts 'Creating test Index "The Fund"'
i = Index.new
i.name = 'The Fund'
i.assign_codes([
  Asset.all.sample.code,
  Asset.all.sample.code,
  Asset.all.sample.code,
  Asset.all.sample.code,
  Asset.all.sample.code,
  Asset.all.sample.code
])
i.user = User.new(name: 'Ya Boi', email: 'itsyaboi@gmail.com')
i.save
