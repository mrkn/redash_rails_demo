# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CSV.foreach(File.expand_path('../train.csv', __FILE__)) do |row|
  Passenger.create!(
    id: row[0],
    survived: row[1],
    pclass: row[2],
    name: row[3],
    sex: row[4],
    age: row[5],
    sibsp: row[6],
    parch: row[7],
    ticket: row[8],
    fare: row[9],
    cabin: row[10],
    embarked: row[11]
  )
end
