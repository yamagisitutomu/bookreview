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


正田 = Customer.find_or_create_by!(email: "masada@masada") do |customer|
  customer.name = "正田"
  customer.password = "masada"
  customer.birthdate = Date.parse("1999-11-11")
  customer.gender = "男性"
  customer.is_active = true
end

山田 = Customer.find_or_create_by!(email: "yamada@yamada") do |customer|
  customer.name = "山田"
  customer.password = "yamada"
  customer.birthdate = Date.parse("2000-12-22")
  customer.gender = "女性"
  customer.is_active = true
end

require 'net/http'
require 'json'

# 楽天APIのURLとAPIキーを設定
api_url = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404"
api_key = ENV['RWS_APPLICATION_ID']

# ISBNを指定
target_isbns = ['9784863895201']

target_isbns.each do |target_isbn|
  # リクエストパラメータを設定
  query_params = {
    format: 'json',
    isbn: target_isbn,
    applicationId: api_key,
  }

# APIにリクエストを送信
uri = URI(api_url)
uri.query = URI.encode_www_form(query_params)
response = Net::HTTP.get_response(uri)

  # レスポンスが成功した場合、本の情報を取り出してデータベースに格納
  if response.is_a?(Net::HTTPSuccess)
    data = JSON.parse(response.body)
    book_data = data['Items'].first # 最初の1冊を取得

    isbn = book_data['Item']['isbn']
    title = book_data['Item']['title']
    author = book_data['Item']['author']
    image_url = book_data['Item']['largeImageUrl']
    sales_date = book_data['Item']['salesDate']
    item_url = book_data['Item']['itemUrl']
    
     # Book モデルに格納
    book = Book.find_or_create_by!(isbn: isbn) do |b|
      b.title = title
      b.author = author
      b.image_url = image_url
      b.sales_date = sales_date
      b.item_url = item_url
    end

    # Post モデルに格納（各本に対して異なるユーザーからのレビューを追加）
    customer = Customer.find_or_create_by!(email: "masada@masada") do |c|
      c.name = "正田"
      c.password = "masada"
      c.birthdate = Date.parse("1999-11-11")
      c.gender = "男性"
      c.is_active = true
    end

    Post.find_or_create_by!(
      star: 3,
      review: "ワクワクするような魔法と冒険の話がとても楽しい",
      customer: customer,
      book: book
    )

    customer = Customer.find_or_create_by!(email: "yamada@yamada") do |c|
      c.name = "山田"
      c.password = "yamada"
      c.birthdate = Date.parse("2000-12-22")
      c.gender = "女性"
      c.is_active = true
    end

    Post.find_or_create_by!(
      star: 5,
      review: "読んでいると、どんどん続きが気になって一気に読んでしまうほど楽しかった",
      customer: customer,
      book: book
    )
  end
end


