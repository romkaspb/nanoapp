# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..10).each do |i|
	sender = User.create(
		name: "Sender #{i}",
		password: "123456",
		password_confirmation: "123456",
		email: "sender#{i}@nanoapp.io"
	)

	reciever = User.create(
		name: "Reciever #{i}",
		password: "123456",
		password_confirmation: "123456",
		email: "reciever#{i}@nanoapp.io"
	)
end

ApiKey.create(
	access_token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJuYW1lIjoiU2VuZGVyIDEiLCJhY2Nlc3NfdGltZXN0YW1wIjoxNDg5MzUyODAyfQ.vcmidfi_ApoWwyWttm_ZWwGZtWt9HFcDYxiROTOZfGM",
	user: User.find(1)
)

%w(Vider Telegram).map{|m| Messenger.create(name: m)}