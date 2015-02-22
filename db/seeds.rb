# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create first_name: "Patrick",
            middle_name: "Reid",
            last_name: "Metcalfe",
            email: "spam@patrickmetcalfe.com",
            password: "77057705",
            password_confirmation: "77057705",
            grade: 12,
            school: "St. Ignatius College Prep",
            admin: true
