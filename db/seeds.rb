# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Haiku.delete_all
  Line.delete_all
  5.times do |i|
    Haiku.create().lines.create([
      {content:"first line of haiku #{i}"},
      {content:"second line of haiku #{i}"},
      {content:"third line of haiku #{i}"}
    ])
  end
