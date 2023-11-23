class Public::BooksController < ApplicationController
  before_action :some_action, only: [:index]
  before_action :load_book, only: [:show]
  
  def search
    @title = params[:title]
    return unless @title.present?
    
  end

  # モデルにsome_actionでのデータの保存の記述
  def some_action
    @title = params[:title]
    @search_result = Book.fetch_and_save_from_rakuten(@title)
  end
  
  
  def index
    # 楽天APIからデータ習得
    @books = RakutenWebService::Books::Book.search(title: params[:title])
    
  end
  
  def show
    @book = Book.find_by(isbn: params[:isbn])
    @post = Post.new(book: @book)
    # 有効な顧客のみを取得
    @reviews = @book.posts.joins(:customer).where(customers: { is_active: true })
    # 有効な顧客のコメントのみを取得
    @comments = Comment.joins(:customer).where(customers: { is_active: true })
  end

  private


  def load_book
    @book = Book.find_by(isbn: params[:isbn])
  end
  
  def book_params
    params.require(:book).permit(:id, :star, :title, :author, :isbn, :sales_date, :image_url, :itm_url)
  end
end