User.create! name: "Admin", email: "admin@gmail.com",
  password: "123456", password_confirmation: "123456",
  admin: true, activated: true, activated_at: Time.zone.now

User.create! name: "Nguyen Tung Bai", email: "tungbai121@gmail.com",
  password: "123456", password_confirmation: "123456",
  admin: true, activated: true, activated_at: Time.zone.now

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email,
    password: password, password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
end

users = User.order(:created_at).take 6
30.times do
  content = Faker::Lorem.sentence 5
  users.each{|user| user.microposts.create! content: content}
end
