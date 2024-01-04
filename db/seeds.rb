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


masada = Customer.find_or_create_by!(email: "masada@masada") do |customer|
  customer.name = "正田"
  customer.password = "masada"
  customer.birthdate = Date.parse("1999-11-11")
  customer.gender = "男性"
  customer.is_active = true
end

yamada = Customer.find_or_create_by!(email: "yamada@yamada") do |customer|
  customer.name = "山田"
  customer.password = "yamada"
  customer.birthdate = Date.parse("2000-12-22")
  customer.gender = "女性"
  customer.is_active = true
end

