# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ProfileType.delete_all
ProfileType.create(:connection_type => "First")
ProfileType.create(:connection_type => "Second")
ProfileType.create(:connection_type => "Handshake")

Setting.delete_all
Setting.create(:description => "Turn on/off location")
Setting.create(:description => "Contact by phone")
Setting.create(:description => "Contact by email")
Setting.create(:description => "Contact by text message")

