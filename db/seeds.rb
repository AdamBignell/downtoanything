# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
include Devise

u = User.create(email: 'admin@dta.ca', username: 'admin', points: 0, team_id: 1, password: 'adminpass', admin: true)
u.skip_confirmation!
u.save!

u2 = User.create(email: 'abignell@sfu.ca', username: 'malign_blade', points: 0, team_id: 1, password: 'gandalf18', admin: true)
u2.skip_confirmation!
u2.save!

c = Challenge.create(name: "Film a mythical beast!", description: 'Film an animal that nobody has every filmed before!')
c.update_attribute(:user_id, u2.id)
c.save!