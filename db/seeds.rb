# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者
Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

# test会員5人分
5.times do |n|
  Customer.create!(
   # n + 1で数字が重複しないようにする
  name: "テストユーザー#{n + 1}",
  email: "test#{n + 1}@test.com",
  gender: "男性",
  birthdate: "2000111#{n + 1}",
  password: "testuser"
  )
end

