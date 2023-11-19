class Book < ApplicationRecord
  validates :title, :author, :isbn, :sales_date, :image_url, presence: true
  # モデルに楽天APIから取得した情報を保存するメソッドを追加
  def self.fetch_and_save_from_rakuten(title)
    puts "Search Title: #{title}"
    results = RakutenWebService::Books::Book.search(title: title)
    # コンソールに結果を表示
  puts "API Results: #{results.inspect}"



    results.each do |result|
      begin
        save_from_rakuten(result)
      rescue StandardError => e
        Rails.logger.error("Rakutenから本を保存する際にエラーが発生しました: #{e.message}")
      end
    end
  end
  
  def self.save_from_rakuten(api_result)
    # APIからのデータを必要な形式に変換し、モデルに保存する処理
    book = Book.new(
      title: api_result['title'],
      author: api_result['author'],
      isbn: api_result['isbn'],
      sales_date: api_result['sales_date'],
      image_url: api_result['mediumImageUrl'].gsub('?_ex=120x120', '')
    )
     # コンソールに保存しようとしている書籍データの内容を表示
  puts "Saving Book: #{book.inspect}"
    book.save
  end

  self.primary_key = "isbn"
  has_many :posts, dependent: :destroy
end