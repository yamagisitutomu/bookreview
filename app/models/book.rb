class Book < ApplicationRecord
  validates :title, :author, :isbn, :sales_date, :image_url, :item_url, presence: true
  
  self.primary_key = "isbn"
  has_many :posts, dependent: :destroy
  has_one_attached :image
  
  # メソッドを使って `Post` モデルを取得する
  def posts_by_isbn
    Post.where(book_isbn: self.isbn)
  end
  
  # モデルに楽天APIから取得した情報を保存するメソッドを追加
  def self.fetch_and_save_from_rakuten(title)
   
    results = RakutenWebService::Books::Book.search(title: title)
    

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
      image_url: api_result['mediumImageUrl'].gsub('?_ex=120x120', ''),
      item_url: api_result['itemUrl']  # APIから商品ページのURLを取得
    )
   
    book.save
  end
  
  # 画像をリサイズするメソッド
  def resize_image
    return unless image.attached?

    tempfile = MiniMagick::Image.read(image.download)
    tempfile.resize '100x100'  # 任意のサイズに変更
    image.attach(io: tempfile, filename: "#{isbn}_resized.jpg", content_type: 'image/jpeg')
  end
  
  def review_count
    posts.where.not(review: nil).count
  end
  
end