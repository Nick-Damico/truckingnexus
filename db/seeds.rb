# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'SEEDING COMPANIES'

Scrapers::Company.new.call unless File.exist?(Scrapers::Company::JSON_DATA_FILE_PATH)

file = File.open(Scrapers::Company::JSON_DATA_FILE_PATH)
JSON.parse(file.read).each do |company|
  Company.find_or_create_by!(name: company['name'], city: company['city'], state: company['state'])
end
