# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.create!(name: "Example User",
			email: "example@railstut.org",
			password: "123456",
			password_confirmation: "123456",
			admin: true,
			activated: true,
			activated_at: Time.zone.now)

User.create!(name: "Real Person",
			email: "natasha.schimka@chargify.com",
			password: "123456",
			password_confirmation: "123456",
			activated: true,
			activated_at: Time.zone.now)

98.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstut.org"
	password = "password"
	User.create!(name: name,
				email: email,
				password: password,
				password_confirmation: password,
				activated: true,
				activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do |n|
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.microposts.create!(content: content)}
end